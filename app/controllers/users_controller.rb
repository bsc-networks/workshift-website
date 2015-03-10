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
    @user_info = params[:user_info]
    if @user_info.length == 0
      flash[:alert] = 'Must input at least one user'
      render 'devise/invitations/new'
      return
    end
    num_invited = 0
    CSV.parse(@user_info) do |row|
      if row.length != 2
        flash[:alert] = 'Improperly formatted user information on row #'\
          "#{num_invited + 1}"
        render 'devise/invitations/new'
        return
      end
      User.invite!(name: row[0].strip, email: row[1].strip)
      num_invited += 1
    end
    flash[:notice] = "Invited #{num_invited} new users."
    redirect_to root_url
  end
end
