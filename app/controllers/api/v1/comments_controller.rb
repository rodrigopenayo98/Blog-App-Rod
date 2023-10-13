class Api::V1::CommentsController < ApplicationController
  before_action :find_post, only: %i[index create]

  def index
    @comments = @post.comments
    render json: @comments
  end

  def create
    @comment = @post.comments.new(comment_paramas)
    @comment.user = current_user
    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def find_post
    @post = Post.find(params[:post_id])
  end
end
