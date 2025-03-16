class CommentsController < ApplicationController
  def create
    @card = Card.find(params[:card_id])
    @comment = @card.comments.create(params[:comment].permit(:body))
    redirect_to card_path(@card)
  end

  def destroy
    @card = Card.find(params[:card_id])
    @comment = @card.comments.find(params[:id])
    @comment.destroy
    redirect_to card_path(@card)
  end

  private

    def set_card
      @card = Card.find(params[:card_id])
    end
end
