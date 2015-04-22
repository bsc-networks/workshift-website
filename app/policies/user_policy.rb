class UserPolicy < ApplicationPolicy
  def add_users?
    user.workshift_manager?
  end

  def delete_all?
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

  def download_report?
    user.workshift_manager?
  end

  def view_report?
    user.workshift_manager?
  end
end
