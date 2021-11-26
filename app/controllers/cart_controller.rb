class CartController < ApplicationController
  def index; end

  def create
    # logger.debug("Adding #{params[:card_id]} to cart.")
    id = params[:card_id].to_i
    session[:shopping_cart] << id
    card = Card.find(id)
    flash[:notice] = "#{card.name} has been added to your cart."
    redirect_to card_path(id: id)
  end

  def destroy
    id = params[:id].to_i
    session[:shopping_cart].delete(id)
    card = Card.find(id)
    flash[:notice] = "#{card.name} removed from cart."
    redirect_to cart_index_path
  end
end
