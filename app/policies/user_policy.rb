class UserPolicy < ApplicationPolicy
  def add_users?
    user.workshift_manager?
  end

  def delete_all?
    user.workshift_manager?
  end

  def update_required_hours?
    user.workshift_manager?
  end

  def update_mult_required_hours?
    user.workshift_manager?
  end

  def update_workshift_selling_limit?
    user.workshift_manager?
  end

  def update_quiet_hours?
    user.workshift_manager?
  end

  def update_category_preferences?
    user == record
  end

  def update_schedule?
    user == record
  end

  def reports?
    user.workshift_manager?
  end

  def download_semester_report?
    user.workshift_manager?
  end

  def download_report?
    user.workshift_manager?
  end

  def view_semester_report?
    user.workshift_manager?
  end

  def view_report?
    user.workshift_manager?
  end
end
