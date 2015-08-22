class StandaloneWorkshiftSignoffController < ApplicationController
  def index
    @users = User.all
  end

  def load_user
    @users = User.all
    workshifter_id = params[:workshifter_id].to_i
    if workshifter_id < 0
      flash[:alert] = "Please select a valid workshifter."
      @user = nil
    else
      @user = User.find(workshifter_id)
      @workshifts = @user.workshift_assignments.select do |assignment|
        assignment.can_check_off? || assignment.status == "upcoming"
      end
    end
    render :template => "standalone_workshift_signoff/index", :locals => {:user => @user, :workshifts => @workshifts}
  end
end
