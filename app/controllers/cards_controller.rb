class CardsController < ApplicationController
  def index
    # @cards = Card.includes(:card_types).all

    # with pagination
    @cards = Card.includes(:card_types).page params[:page]
  end

  def show
    @card = Card.find(params[:id])
  end
end
