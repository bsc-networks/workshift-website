class UsersController < ApplicationController
  before_filter :authenticate_user!
  after_filter :verify_authorized, except: [:index, :profile, :preferences]

  HOURS_PER_WEEK = 168

  def index
    @users = User.all
  end

  def profile
    id = params[:id] || current_user.id
    @user = User.find(id)
    @quiet_hours = Quiet_hours.new
    @preferences = @user.sorted_preferences
    @verifier_list = User.all.map {|c| c.attributes.slice("name", "id")}
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

  def get_quiet_hour_as_str(params)
    hour = params[0].to_i
    clock = hour > 12 ? "pm" : "am"
    if hour == 0
      hour_str = "12"
    elsif hour > 12 # if more than 12 we substract 12 to keep the AM/PM format
      hour_str = (hour - 12).to_s
    else
      hour_str = params[0]
    end
    hour_str.to_s + ":" + params[1] + clock
  end

  def update_quiet_hours
    authorize :user
    @user = User.find_by_id(params[:id])
    start = get_quiet_hour_as_str(params[:start_quiet_hours].values)
    stop = get_quiet_hour_as_str(params[:stop_quiet_hours].values)
    Quiet_hours.new.set_quiet_hours(start, stop)
    redirect_to user_profile_path(@user)
  end

  def update_required_hours
    authorize :user
    @user = User.find_by_id(params[:id])
    required_hours = params[:required_hours].to_f
    if required_hours >= 0 and required_hours <= HOURS_PER_WEEK
      @user.update_required_hours(required_hours)
    else
      flash[:alert] = "Required hours should be equal or greater than 0 but equal or less than #{HOURS_PER_WEEK}."
    end
    redirect_to user_profile_path(@user)
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
    new_schedule = User.parse_schedule_params(params[:schedule])
    current_user.schedule = new_schedule
    current_user.save!
    flash[:notice] = 'Successfully updated student schedule'
    redirect_to root_url
  end
end
