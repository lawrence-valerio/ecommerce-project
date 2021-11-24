class CheckoutController < ApplicationController
  def create
    product = Product.find(params[:card_id])
    if product.nil?
      redirect_to cards
      return
    end

    @session = Stripe::Checkout::Session.create(
      # went to stripe API, looked up sessions, figured it all out..
      payment_method_types: ['card'],
      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: checkout_cancel_url,
      line_items: [
        {
          name: product.name,
          description: product.description,
          amount: product.price_cents,
          currency: 'cad',
          quantity: 1 # We will hardcode one for this demo.
        },
        {
          name: 'GST',
          description: 'Goods and Services Tax',
          amount: (product.price_cents * 0.05).to_i,
          currency: 'cad',
          quantity: 1
        }
      ]
    )

    respond_to do |format|
      format.js # render app/views/checkout/create.js.erb
    end
  end

  def success
    # stripe success_url +"?session_id={CHECKOUT_SESSION_ID}"
    # when stripe redirects back to server... it will append this session_id  through GET params!
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    # found in the docs!
  end

  def cancel
    # something went wrong :(
  end
end
