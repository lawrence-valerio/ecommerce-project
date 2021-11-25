class CheckoutController < ApplicationController
  def create
    @card = Card.find(params[:card_id])

    if @card.nil?
      redirect_to cards
      nil
    end

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
