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
end
