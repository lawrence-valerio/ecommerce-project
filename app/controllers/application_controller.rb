class ApplicationController < ActionController::Base
  before_action :set_variables

  def set_variables
    @global_types = Type.includes(:card_types).all
    @global_rarities = Rarity.all
  end
end
