class UsersController < ApplicationController
  def index
    @user = User.includes(:posts)
  end

  def show
    @user = User.find(params[:id])
  end

  def current_user
    User.first
  end
end
