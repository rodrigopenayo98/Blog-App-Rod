class UsersController < ApplicationController
  def index
    @users = User.all

    puts "Original UsersController - Index Action"
    log_query_count
  end

  def show
    @user = User.find(params[:id])
  end

  def current_user
    User.first
  end

  def log_query_count
    puts "Number of SQL Queries: #{ActiveRecord::Base.connection.query_cache.length}"
  end
end
