class PostsController < ApplicationController
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

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
