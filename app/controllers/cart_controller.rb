class CartController < ApplicationController
  def index
    @user = User.find(current_user.id) unless current_user.nil?
  end

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
    @user = User.find(current_user.id) unless current_user.nil?

    id = params[:id]
    card = Card.find(id)
    quantity = params[:quantity]
    new_price = card.price * quantity.to_i
    session[:shopping_cart][id.to_s]['quantity'] = quantity
    session[:shopping_cart][id.to_s]['price'] = new_price

    temp_total = 0
    session[:shopping_cart].each do |_key, value|
      price = value['price'].to_f
      temp_total += price
    end

    session[:first_total] = temp_total.round(2)

    unless current_user.nil?
      @user = User.find(current_user.id)
      session[:gst] = (temp_total * @user.province.gst).round(2)
      session[:hst] = (temp_total * @user.province.hst).round(2)
      session[:pst] = (temp_total * @user.province.pst).round(2)
      session[:final_total] = (session[:first_total] + session[:gst] + session[:hst] + session[:pst]).round(3)
    end
  end
end
