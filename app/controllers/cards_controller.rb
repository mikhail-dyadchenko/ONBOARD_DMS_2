class CardsController < ApplicationController
  load_and_authorize_resource
  def index
    if current_user
      @cards = current_user.cards
    else
      @cards = Card.all
    end
  end

  def show
    @card = Card.find(params[:id])
  end
end
