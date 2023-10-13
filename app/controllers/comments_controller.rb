class CommentsController < ApplicationController
  before_action :set_post

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.post = @post

    if @comment.save
      flash[:notice] = 'A new comment was created!'
      redirect_to user_post_path(@comment.post.author_id, @comment.post.id)
    else
      flash.now[:error] = 'There was an error, the comment could not be created'
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
  def destroy
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment
    if @comment.destroy
      flash.now[:success] = 'Comment was successfully deleted!'
    else
      flash[:error] = 'Comment couldnt be deleted!'
    end
    redirect_to user_post_path(@comment.post.author, @comment.post)
  end
end
