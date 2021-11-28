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

    @stripe_session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: checkout_cancel_url,
      line_items: @lineItems
    )

    respond_to do |format|
      format.js
    end
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)

    user = User.find(current_user.id)
    status = Status.find_or_create_by(
      order_status: 'complete'
    )

    order = Order.create(
      order_total: @session.amount_total,
      status: status,
      user: user,
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

    session[:shopping_cart] = {}
    session[:first_total] = []
    session[:gst] = []
    session[:hst] = []
    session[:pst] = []
    session[:final_total] = []
    session[:first_total_cents] = []
  end

  def cancel; end

  private

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
