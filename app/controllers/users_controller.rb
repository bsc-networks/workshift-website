require 'csv'

class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.all
  end

  def profile
    id = params[:id] || current_user.id
    @user = User.find(id)
    @assigned_workshifts = @user.assigned_workshifts
  end

  def add_users
    user_info = params[:user_info]
    if user_info.length == 0
      flash[:alert] = 'Improperly formatted user information'
      flash.keep
      redirect_to root_url
      return
    end
    CSV.parse(user_info).each do |row|
      puts row
    end
    redirect_to root_url
  end
end
