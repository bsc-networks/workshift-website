class WorkshiftAssignmentPolicy < ApplicationPolicy
  def check_off?
    user == record.workshifter
  end

  # user cannot be same as seller
  def sell_to?
    user != record.workshifter
  end

  def put_on_market?
    user == record.workshifter
  end

  def undo_sell?
    user == record.workshifter
  end
end