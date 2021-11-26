class TypesController < ApplicationController
  def index
    @types = Type.includes(:card_types).all
  end

  def show
    @type = Type.find(params[:id])

    @filtered_cards = @type.cards.page params[:page]
  end
end
