class WorkshiftAssignmentPolicy < ApplicationPolicy
  def check_off
    user == @workshift_assignment.workshifter
  end

  def sell_to
    user == Workshift_assignment.find(params[:buyer_id])
  end


  def put_on_market
    user == @worksfhit_assignment.workshifter
  end

  def undo_sell
    user == @workshift_assignment.workshifter
  end
end