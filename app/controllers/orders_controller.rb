class OrdersController < ApplicationController
  def index
    user = User.find(current_user.id)

    @orders = Order.where(user: user).page params[:page]
  end

  def show
    @subtotal = 0

    @user = User.find(current_user.id)

    @order = Order.find(params[:id])

    @card_order = CardOrder.where(order: @order)

    calculate_total
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
end
