class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_variables, :initialize_session
  helper_method :cart

  def set_variables
    @global_types = Type.includes(:card_types).all
    @global_rarities = Rarity.all
    @global_provinces = Province.all
  end

  private

  def initialize_session
    session[:shopping_cart] ||= {}
  end

  def cart
    id_array = session[:shopping_cart].keys

    Card.find(id_array)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[address name province_id email password password_confirmation])
  end
end
