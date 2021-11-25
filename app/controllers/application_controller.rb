class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_variables

  def set_variables
    @global_types = Type.includes(:card_types).all
    @global_rarities = Rarity.all
    @global_provinces = Province.all
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[address name province_id email password password_confirmation])
  end
end
