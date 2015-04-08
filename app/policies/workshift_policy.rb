class WorkshiftPolicy < ApplicationPolicy
  def new?
    user.workshift_manager?
  end

  def edit?
    user.workshift_manager?
  end

  def create?
    user.workshift_manager?
  end

  def update?
    user.workshift_manager?
  end

  def destroy?
    user.workshift_manager?
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
