class WorkshiftAssignmentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_workshift_assignment, only: [:check_off, :put_on_market, :sell_to, :undo_sell]

  def check_off
    authorize @workshift_assignment
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
    ConfirmationMailer.sign_off_email(@workshift_assignment.verifier.email, @workshift_assignment.workshifter).deliver
    flash[:alert] = "Assignment successfully checked off"
    redirect_to user_profile_path(@workshift_assignment.workshifter)
  end

  def marketplace_index
    @assignments_on_sale = WorkshiftAssignment.assignments_on_market
  end

  def put_on_market
    authorize @workshift_assignment
    if @workshift_assignment.can_put_on_market?
      @workshift_assignment.put_on_market
      redirect_to marketplace_path
    else
      flash[:alert] = "You can not put a workshift on the marketplace after it has started."
      redirect_to user_profile_path(@workshift_assignment.workshifter)
    end
  end

  def sell_to
    authorize @workshift_assignment
    if current_user != User.find(params[:buyer_id])
      flash[:alert] = "Unauthorized action"
      redirect_to user_profile_path(currrent_user)
      return
    end
    if @workshift_assignment.on_market?
      @workshift_assignment.sell_to(current_user)
      flash[:notice] = "Successfully bought workshift"
      redirect_to user_profile_path(currrent_user)
    else
      flash[:alert] = "Cannot buy a workshift that is not on the market."
      redirect_to user_profile_path(current_user)
    end
  end

  def undo_sell
    authorize @workshift_assignment
    if @workshift_assignment.can_undo_sell?
      @workshift_assignment.undo_sell
    else
      flash[:alert] = "You cannot undo a sell after the shift has started."
      redirect_to user_profile_path(@workshift_assignment.workshifter)
    end
  end

  private

  def set_workshift_assignment
    @workshift_assignment = WorkshiftAssignment.find(params[:id])
  end
end