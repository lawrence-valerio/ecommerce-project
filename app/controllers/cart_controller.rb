class CartController < ApplicationController
  def index; end

  def create
    quantity = params[:quantity].to_i
    id = params[:card_id].to_i
    card = Card.find(id)
    total_price = card.price * quantity
    session[:shopping_cart][id] = { 'quantity' => quantity, 'price' => total_price }
    flash[:notice] = "#{card.name} has been added to your cart."
    redirect_to card_path(id: id)
  end

  def destroy
    id = params[:id].to_s
    session[:shopping_cart].delete(id)
    card = Card.find(id)
    flash[:notice] = "#{card.name} removed from cart."
    redirect_to cart_index_path
  end

  def update
    id = params[:id]
    card = Card.find(id)
    quantity = params[:quantity]
    new_price = card.price * quantity.to_i
    session[:shopping_cart][id.to_s]['quantity'] = quantity
    session[:shopping_cart][id.to_s]['price'] = new_price
  end
end
