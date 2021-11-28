class CheckoutController < ApplicationController
  def create
    if session[:final_total].nil? || session[:first_total].nil? || current_user.nil?
      redirect_to cards
      nil
    end

    @user = User.find(current_user.id)

    @lineItems = []

    session[:shopping_cart].each do |key, value|
      card = Card.find(key)
      @lineItems << { name: card.name,
                      description: card.description,
                      amount: card.price.to_i,
                      currency: 'cad',
                      quantity: value['quantity'].to_i }
    end

    check_tax(@user.province.gst)
    check_tax(@user.province.pst)
    check_tax(@user.province.hst)

    # CREATING THE ORDER FOR THE DATABASE
    status = Status.where(order_status: 'pending').first

    order = Order.create(
      order_total: session[:final_total],
      status: status,
      user: @user,
      hst: session[:hst],
      gst: session[:gst],
      pst: session[:pst]
    )

    session[:shopping_cart].each do |key, value|
      card = Card.find(key)
      CardOrder.create(order: order,
                       card: card,
                       quantity: value['quantity'].to_i,
                       price: (card.price.to_i * value['quantity'].to_i) / 100)
    end

    @stripe_session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}' + "&id=#{order.id}",
      cancel_url: checkout_cancel_url + "?id=#{order.id}",
      line_items: @lineItems
    )

    order.stripe_id = @stripe_session.id

    respond_to do |format|
      format.js
    end
  end

  def success
    @subtotal = 0

    status = Status.where(order_status: 'complete').first

    @order = Order.find(params[:id])
    @order.status = status
    @order.save
    @user = User.find(current_user.id)

    @card_order = CardOrder.where(order: @order)

    calculate_total

    session[:shopping_cart] = {}
    session[:first_total] = []
    session[:gst] = []
    session[:hst] = []
    session[:pst] = []
    session[:final_total] = []
    session[:first_total_cents] = []
  end

  def cancel
    order = Order.find(params[:id])
    order.destroy
  end

  private

  def calculate_total
    temp_total = 0
    @card_order.each do |card|
      card_total = (card.card.price / 100.0) * card.quantity
      temp_total += card_total
    end
    @subtotal = temp_total
  end

  def check_tax(tax)
    puts(session[:first_total_cents] * tax)
    if tax > 0.0
      @lineItems << {
        name: 'GST',
        description: 'Goods and Services Tax',
        amount: (session[:first_total_cents] * tax).round.to_i,
        currency: 'cad',
        quantity: 1
      }
    end
  end
end
