class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @user = User.includes(posts: :comments).find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
  end

  def new
    @user = current_user
    @post = @user.posts.includes(:comments).find(params[:id])
  end

  def create
    @user = current_user
    @post = Post.new(
      author: @user,
      title: params[:post][:title],
      text: params[:post][:text],
      commentsCounter: 0,
      likesCounter: 0
    )

    if @post.save
      flash.now[:error] = 'You have created a new post!'
      redirect_to user_posts_path(@user)
    else
      flash.now[:error] = 'An error occurred while creating the post'
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])

    authorize! :destroy, @post
    if @post.destroy
      flash.now[:success] = 'Post was successfully deleted!'
      redirect_to user_posts_path
    else
     flash[:error] = 'Post couldnt be deleted!'
  redirect_to user_posts_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
