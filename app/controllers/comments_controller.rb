class CommentsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def create
    @card = Card.find(params[:card_id])
    @comment = @card.comments.create(params[:comment].permit(:body))
    redirect_to admin_card_path(@card)
  end

  def destroy
    @card = Card.find(params[:card_id])
    @comment = @card.comments.find(params[:id])
    @comment.destroy
    redirect_to admin_card_path(@card)
  end

  private

    def set_card
      @card = Card.find(params[:card_id])
    end

    def comment_params
      params.require(:comment).permit(:body).merge(card_id: params[:card_id])
    end
end
