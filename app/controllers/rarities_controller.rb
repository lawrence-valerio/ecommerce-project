class RaritiesController < ApplicationController
  def index
    @rarities = Rarity.all
  end

  def show
    @rarity = Rarity.find(params[:id])
  end
end
