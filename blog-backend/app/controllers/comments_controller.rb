class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :update, :destroy]

  def index
    render json: { comments: Comment.all }, methods: :post_id
  end

  def show
    render json: { comment: @comment }, methods: :post_id
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      render json: { comment: @comment }, methods: :post_id, status: :created, location: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy

    head :no_content
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:author, :body, :post_id)
  end
end
