class UsersController < ApplicationController
  before_filter :authenticate_user!
  after_filter :verify_authorized, except: [:index, :profile, :preferences]

  def index
    @users = User.all
  end

  def profile
    id = params[:id] || current_user.id
    @user = User.find(id)
    @workshift_assignments = @user.workshift_assignments
  end

  def add_users
    authorize :user
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
    authorize :user
    User.delete_all_residents
    flash[:notice] = 'All current residents deleted.'
    redirect_to root_url
  end

  def preferences
    @preferences = Preference.all
  end

  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    msg = 'You are not authorized to perform this action.'
    flash[:alert] = I18n.t "pundit.#{policy_name}.#{exception.query}",
                           default: msg
    redirect_to request.referrer || root_url
  end
end
