class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.all
  end

  def profile
    id = params[:id] || current_user.id
    @user = User.find(id)
    @workshift_assignments = @user.workshift_assignments
  end

  def add_users
    @user_info = params[:user_info]
    begin
      num_invited = User.invite_users(@user_info)
      # num_s used to change user -> users when more than 1 user invited
      num_s = num_invited > 1 ? 1 : 0
      flash[:notice] = "Invited #{num_invited} new user#{'s' * num_s}."
      redirect_to root_url
    rescue ArgumentError => e
      flash[:alert] = e.message
      render 'devise/invitations/new'
    end
  end

  def delete_all
    User.delete_all_residents
    flash[:notice] = 'All current residents deleted.'
    redirect_to root_url
  end
end
