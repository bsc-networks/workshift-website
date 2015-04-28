class UsersController < ApplicationController
  before_filter :authenticate_user!
  after_filter :verify_authorized, except: [:index, :profile, :preferences]

  def index
    @users = User.all
  end

  def profile
    id = params[:id] || current_user.id
    @user = User.find(id)
    @preferences = @user.sorted_preferences
    @workshift_assignments = @user.workshift_assignments.select do |assignment|
      assignment.can_check_off? || assignment.status == "upcoming"
    end
    @workshift_assignments_history = @user.workshift_assignments.select do |assignment|
      assignment.status != 'upcoming'
    end
    @room_number = @user.room_number.length > 0 ? @user.room_number : ''
    @email = @user.display_email? ? @user.email : ''
    @phone_number = (@user.display_phone_number? && @user.phone_number.length > 0) ? @user.phone_number : ''
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

  def reports
    authorize :user
    @reports = WeeklyReport.order('created_at DESC')
  end

  def download_semester_report
    authorize :user
    report = WeeklyReport.semester_report
    send_data report, type: 'text/csv; charset=utf-8; header=present',
                      disposition: "attachment; filename=semester_report.csv"
  end

  def download_report
    authorize :user
    report = WeeklyReport.find(params[:id])
    send_data report.text, type: 'text/csv; charset=utf-8; header=present',
                           disposition: "attachment; filename=#{report.title}"
  end

  def view_semester_report
    authorize :user
    @text = WeeklyReport.semester_report
  end

  def view_report
    authorize :user
    @report = WeeklyReport.find(params[:id])
  end

  def preferences
    @categories = Category.all
    @schedule = current_user.schedule == {} ? User.create_schedule : current_user.schedule
  end

  def update_category_preferences
    authorize current_user
    preferences = params[:preferences]
    begin
      current_user.update_category_preferences(preferences)
      flash[:notice] = 'Successfully updated category preferences'
      redirect_to root_url
    rescue ArgumentError => e
      flash[:alert] = e.message
      @categories = Category.all
      @schedule = current_user.schedule == {} ? User.create_schedule : current_user.schedule
      render 'users/preferences'
    end
  end

  def update_schedule
    authorize current_user
    schedule_params = params[:schedule]
    #begin
    new_schedule = User.parse_schedule_params(schedule_params)
    current_user.schedule = new_schedule
    current_user.save!
    flash[:notice] = 'Successfully updated student schedule'
    redirect_to root_url
    #rescue ArgumentError => e
    #  flash[:alert] = e.message
    #  @categories = Category.all
    #  render 'users/preferences'
    #end
  end
end
