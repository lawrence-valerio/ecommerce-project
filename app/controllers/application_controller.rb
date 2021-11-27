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
    session[:gst] ||= []
    session[:hst] ||= []
    session[:pst] ||= []
    session[:final_total] ||= []
  end

  def cart
    id_array = session[:shopping_cart].keys
    temp_total = 0
    session[:shopping_cart].each do |_key, value|
      price = value['price'].to_f
      temp_total += price
    end

    unless current_user.nil?
      @user = User.find(current_user.id)
      session[:first_total] = temp_total.round(2)
      session[:gst] = (temp_total * @user.province.gst).round(2)
      session[:hst] = (temp_total * @user.province.hst).round(2)
      session[:pst] = (temp_total * @user.province.pst).round(2)
      session[:final_total] = (session[:first_total] + session[:gst] + session[:hst] + session[:pst]).round(2)
    end

    Card.find(id_array)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[address name province_id email password password_confirmation])
  end
end
