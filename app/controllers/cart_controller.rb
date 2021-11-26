class CartController < ApplicationController
  def index; end

  def create
    quantity = params[:quantity].to_i
    id = params[:card_id].to_i
    session[:shopping_cart][id] = quantity
    card = Card.find(id)
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
end
