class WorkshiftAssignmentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_workshift_assignment, only: [:check_off]

  def check_off
    logger.debug "HELPHELPHELP #{params[:verifier]}"
    if !@workshift_assignment.can_check_off?
      flash[:alert] = "Can't check off this workshift yet"
      redirect_to user_profile_path(@workshift_assignment.workshifter)
      return
    end
    verifier = User.find_by_id(params[:verifier])
    if verifier == @workshift_assignment.workshifter
      flash[:alert] = "Verifier cannot be the same person as assigned workshifter"
      redirect_to user_profile_path(@workshift_assignment.workshifter)
      return
    end
    @workshift_assignment.check_off(verifier)
    flash[:alert] = "Assignment successfully checked off"
    redirect_to user_profile_path(@workshift_assignment.workshifter)
  end

  private

  def set_workshift_assignment
    @workshift_assignment = WorkshiftAssignment.find(params[:id])
  end
end