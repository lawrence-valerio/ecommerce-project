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
    session[:first_total] ||= []
  end

  def cart
    id_array = session[:shopping_cart].keys
    temp_total = 0
    session[:shopping_cart].each do |_key, value|
      price = value['price'].to_f
      temp_total += price
    end

    session[:first_total] = temp_total.round(2)
    Card.find(id_array)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[address name province_id email password password_confirmation])
  end
end
