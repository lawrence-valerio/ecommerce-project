class CardsController < ApplicationController
  def index
    # @cards = Card.includes(:card_types).all

    # with pagination
    @cards = Card.includes(:card_types).page params[:page]
  end

  def show
    @card = Card.find(params[:id])
  end

  def search
    @cards = if params[:f] == 'All'
               Card.where('name LIKE ?', '%' + params[:q] + '%').page params[:page]
             else
               Card.joins(:types).where('types.type_name' => params[:f]).where('type_name LIKE ?',
                                                                               '%' + params[:q] + '%').page params[:page]
             end
  end
end
