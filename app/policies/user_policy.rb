class UserPolicy < ApplicationPolicy
  def add_users?
    user.workshift_manager? || user.unit_level_admin?
  end

  def delete_all?
    user.workshift_manager? || user.unit_level_admin?
  end

  def update_required_hours?
    user.workshift_manager?
  end

  def update_unit?
    user.workshift_manager? || user.unit_level_admin?
  end

  def update_category_preferences?
    user == record
  end

  def update_schedule?
    user == record
  end

  def reports?
    user.workshift_manager? || user.unit_level_admin?
  end

  def download_semester_report?
    user.workshift_manager? || user.unit_level_admin?
  end

  def download_report?
    user.workshift_manager? || user.unit_level_admin?
  end

  def view_semester_report?
    user.workshift_manager? || user.unit_level_admin?
  end

  def view_report?
    user.workshift_manager? || user.unit_level_admin?
  end
end
