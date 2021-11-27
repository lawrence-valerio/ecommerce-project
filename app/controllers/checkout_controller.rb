class CheckoutController < ApplicationController
  def create
    if session[:final_total].nil? || session[:first_total].nil? || current_user.nil?
      redirect_to cards
      nil
    end

    @lineItems = []

    session[:shopping_cart].each do |key, value|
      card = Card.find(key)
      @lineItems << { name: card.name,
                      description: card.description,
                      unit_amount_decimal: card.price.to_f,
                      currency: 'cad',
                      quantity: value['quantity'].to_i }
    end

    @stripe_session = Stripe::Checkout::Session.create(
      # went to stripe API, looked up sessions, figured it all out..
      payment_method_types: ['card'],
      success_url: checkout_success_url,
      cancel_url: checkout_cancel_url,
      line_items: @lineItems
    )

    respond_to do |format|
      format.js
    end
  end

  def success
    # stripe success_url +"?session_id={CHECKOUT_SESSION_ID}"
    # when stripe redirects back to server... it will append this session_id  through GET params!
    # @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    # @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    # found in the docs!
  end

  def cancel
    # something went wrong :(
  end
end
