class WorkshiftAssignmentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_workshift_assignment, only: [:check_off, :put_on_market,
                                                  :sell_to, :undo_sell]

  def check_off
    authorize @workshift_assignment
    unless @workshift_assignment.can_check_off?
      flash[:alert] = "Can't check off this workshift yet"
      redirect_to user_profile_path(@workshift_assignment.workshifter)
      return
    end
    verifier = User.find_by_id(params[:verifier])
    if !verifier || verifier == @workshift_assignment.workshifter
      flash[:alert] = 'Invalid verifier'
      redirect_to user_profile_path(@workshift_assignment.workshifter)
      return
    end
    if !verifier.valid_password?(params[:verifier_password])
      flash[:alert] = 'Invalid password for ' + verifier.name
      redirect_to user_profile_path(@workshift_assignment.workshifter)
      return
    end
      @workshift_assignment.check_off(verifier)
    ConfirmationMailer.sign_off_email(@workshift_assignment.verifier.email,
                                      @workshift_assignment.workshifter).deliver
    flash[:notice] = 'Assignment successfully checked off'
    redirect_to user_profile_path(@workshift_assignment.workshifter)
  end

  def marketplace_index
    assignments_on_sale = WorkshiftAssignment.assignments_on_market
    @users_shifts = assignments_on_sale.where(workshifter_id: current_user)
    @buyable_shifts = assignments_on_sale.where('workshifter_id != ?',
                                                current_user)
    @user = current_user
    @workshift_limit = WorkshiftSellingLimit.find(1) # To be replaced by the :id_unit
  end

  def put_on_market
    authorize @workshift_assignment
    if @workshift_assignment.can_put_on_market?
      if @workshift_assignment.late_for_market?
        flash[:alert] = 'Warning: You are already late to sell your workshift. If no one buys the workshift, you will still get blown hours.'
      end
      @workshift_assignment.put_on_market
      redirect_to marketplace_path
    else
      flash[:alert] = 'You can not put a workshift on the marketplace '\
        'after it has started.'
      redirect_to user_profile_path(@workshift_assignment.workshifter)
    end
  end

  def sell_to
    authorize @workshift_assignment
    if current_user != User.find(params[:buyer_id])
      flash[:alert] = 'Unauthorized action'
      redirect_to user_profile_path(current_user)
      return
    end
    if @workshift_assignment.on_market?
      @workshift_assignment.sell_to(current_user)
      flash[:notice] = 'Successfully bought workshift'
      redirect_to user_profile_path(current_user)
    else
      flash[:alert] = 'Cannot buy a workshift that is not on the market.'
      redirect_to user_profile_path(current_user)
    end
  end

  def undo_sell
    authorize @workshift_assignment
    if @workshift_assignment.can_undo_sell?
      @workshift_assignment.undo_sell
      redirect_to user_profile_path(@workshift_assignment.workshifter)
    else
      flash[:alert] = 'You cannot undo a sell after the shift has started.'
      redirect_to user_profile_path(@workshift_assignment.workshifter)
    end
  end

  private

  def set_workshift_assignment
    @workshift_assignment = WorkshiftAssignment.find(params[:id])
  end
end
