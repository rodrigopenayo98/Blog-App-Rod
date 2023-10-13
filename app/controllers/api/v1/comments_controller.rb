class Api::V1::CommentsController < ApplicationController 
  before_action :find_post, only: %i[index create] 
  skip_before_action :verify_authenticity_token 
 
  def index 
    @comments = @post.comments 
    render json: @comments 
  end 
 
  def create 
    @comment = Comment.new(comment_params) 
    if @comment.save 
      render json: @comment, status: :created 
    else 
      render json: @comment.errors, status: :unprocessable_entity 
    end 
  end 
 
  private 
 
  def comment_params 
    params.require(:comment).permit(:text, :post_id, :user_id) 
  end 
 
  def find_post 
    @post = Post.find(params[:post_id]) 
  end 
end
