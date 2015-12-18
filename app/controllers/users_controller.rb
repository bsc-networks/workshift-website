class UsersController < ApplicationController
  before_filter :authenticate_user!
  after_filter :verify_authorized, except: [:index, :profile, :preferences]

  HOURS_PER_WEEK = 168

  def index
    @users = User.where(unit_id: current_user.unit)
  end

  def profile
    id = params[:id] || current_user.id
    @user = User.where(unit_id: current_user.unit).find(id)
    @other_units = (Unit.all.size == 1) ? Unit.all : Unit.find(:all, :conditions => ["id != ?", @user.id])
    if not @user.unit.nil?
      @quiet_hours = @user.unit.quiet_hour
    end
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
      if current_user.admin
        num_invited = User.invite_users_in_units(@user_info)
      else
        num_invited = User.invite_users(@user_info, current_user.unit)
      end
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
    quiet_hours = @user.unit.quiet_hour
    day_param = params[:day].downcase
    start_time_param = params[:start_time]
    start_time_str = start_time_param["start_time(4i)"] + ":" + start_time_param["start_time(5i)"]
    end_time_param = params[:end_time]
    start_time = Time.parse(start_time_str)
    end_time = Time.parse(end_time_param["end_time(4i)"] + ":" + end_time_param["end_time(5i)"])
    if quiet_hours.nil? or quiet_hours.day_quiet_hours.nil? or quiet_hours.day_quiet_hours.empty?
      quiet_hours = QuietHour.new
      quiet_hours.unit_id = @user.unit
      @user.unit.quiet_hour = quiet_hours
      quiet_hours.save
      ['sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday'].each do |day|
        quiet_hours.day_quiet_hours.create(day: day)
      end
    end
    quiet_hours.set_day_start_time(day_param, start_time)
    quiet_hours.set_day_end_time(day_param, end_time)
    redirect_to user_profile_path(@user)
  end

  def update_workshift_selling_limit
    authorize :user
    @user = User.find_by_id(params[:id])
    time_limit = params[:workshift_selling_limit].to_i
    if time_limit >= 0
      workshift_selling_limit = WorkshiftSellingLimit.where(id: 1).first # WHERE id_unit to be added
      workshift_selling_limit.time_limit = time_limit
      workshift_selling_limit.save
      flash[:notice] = "Workshift Selling Limit set to #{time_limit}."
    else
      flash[:alert] = 'Workshift Selling Limit should be greater or equal to zero.'
    end
    redirect_to marketplace_path(@user)
  end

  def update_required_hours
    authorize :user
    @user = User.where(unit_id: current_user.unit).find_by_id(params[:id])
    required_hours = params[:required_hours].to_f
    if required_hours >= 0 and required_hours <= HOURS_PER_WEEK
      @user.update_required_hours(required_hours)
    else
      flash[:alert] = "Required hours should be equal or greater than 0 but equal or less than #{HOURS_PER_WEEK}."
    end
    redirect_to user_profile_path(@user)
  end

  def update_unit
    # When a user changes units, all preferences and workshifts are cleaned from the user, but the workshifts remain on the unit
    authorize :user
    @user = User.where(unit_id: current_user.unit).find_by_id(params[:id])
    unit = Unit.find_by_name(params[:unit])
    if unit == nil
      flash[:alert] = "No such unit exists : #{params[:unit]}."
      redirect_to user_profile_path(@user) and return
    elsif unit.id == @user.unit.id
      flash[:alert] = "User is already in selected unit : #{params[:unit]}."
      redirect_to user_profile_path(@user) and return
    else
      @user.preferences.destroy_all
      @user.workshifts.delete_all
      @user.workshift_assignments.delete_all
      @user.update_unit(unit)
    end
    redirect_to roster_url
  end

  def delete_all
    authorize :user
    User.delete_all_residents(current_user.unit)
    flash[:notice] = 'All current residents deleted.'
    redirect_to root_url
  end

  def reports
    authorize :user
    @reports = WeeklyReport.order('created_at DESC')
  end

  def download_semester_report
    authorize :user
    report = WeeklyReport.semester_report(current_user.unit)
    send_data report, type: 'text/csv; charset=utf-8; header=present',
              disposition: "attachment; filename=semester_report.csv"
  end

  def download_report
    authorize :user
    report = WeeklyReport.find(params[:id])
    send_data report.text(current_user.unit), type: 'text/csv; charset=utf-8; header=present',
              disposition: "attachment; filename=#{report.title}"
  end

  def view_semester_report
    authorize :user
    @text = WeeklyReport.semester_report(current_user.unit)
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
