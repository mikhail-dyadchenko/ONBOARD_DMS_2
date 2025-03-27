class Admin::CommentsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def index
    @comments = Comment.all
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  def create
    @comment = current_user.comments.new(comment_params)
    @card = Card.find(params[:card_id])

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.card, notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
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
