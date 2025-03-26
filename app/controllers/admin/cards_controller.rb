class Admin::CardsController < ApplicationController
  load_and_authorize_resource
  # GET /cards or /cards.json
  def index
    @cards = Card.all
  end
end
