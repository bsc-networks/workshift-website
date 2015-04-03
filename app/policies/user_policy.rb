class UserPolicy < ApplicationPolicy
  def add_users?
    user.workshift_manager?
  end

  def modify_categories?
    user.workshift_manager?
  end

  def delete_all?
    user.workshift_manager?
  end
end
