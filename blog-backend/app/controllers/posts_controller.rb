class PostsController < ApplicationController
  before_action :set_post, only: [:show, :destroy]

  def index
    render json: { posts: Post.all, comments: Comment.all }, methods: :comment_ids
  end

  def show
    render json: { post: @post, comments: @post.comments }, methods: :comment_ids
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      render json: { post: @post, comments: @post.comments }, methods: :comment_ids, status: :created, localtion: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy

    head :no_content
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
