class WorkshiftEditPolicy < Struct.new(:user, :workshift_edit)
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
end