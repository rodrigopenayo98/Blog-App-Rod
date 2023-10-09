class UsersController < ApplicationController
  def index
    @users = User.includes(:posts).find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def current_user
    User.first
  end
end
