class TypesController < ApplicationController
  def index
    @Types = Type.includes(:card_types).all
  end

  def show; end
end
