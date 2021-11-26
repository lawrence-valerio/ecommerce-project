class RaritiesController < ApplicationController
  def index
    @rarities = Rarity.all
  end

  def show
    @rarity = Rarity.find(params[:id])

    @filtered_rarity = @rarity.cards.page params[:page]
  end
end
