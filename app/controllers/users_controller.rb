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
end


def invite_user
  @user = User.invite!({:email => "chan.m.trinh@gmail.com"}, name: "Shirley Trinh")
end