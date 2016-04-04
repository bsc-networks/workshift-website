class PoliciesController < ApplicationController
  before_action :set_policy, only: [:show, :edit, :update, :destroy]

  # GET /policies/1
  # GET /policies/1.json
  def show
    @policy = @current_user.unit.policy
    if not @policy
      if @current_user.is_ws_manager?
        redirect_to new_policy_path
      else
        flash[:info] = "The policies have not been set for this semester."
        redirect_to '/'
      end
    end
  end

  # GET /policies/new
  def new
    if @current_user.is_ws_manager?
      if @current_user.unit.policy
        flash[:notice] = "Your policies have already been set for this semester. Edit your policies below."
        redirect_to edit_policy_path
      end
      @policy = Policy.new
      @defaultDate = Date.today.to_s
      @defaultFine = 10
      @defaultLimit = 2
    else
      flash[:notice] = "You cannot set the policies for this semester. Contact the workshift manager."
      redirect_to policy_path
    end
  end

  # GET /policies/1/edit
  def edit
    if @current_user.is_ws_manager?
      @policy = @current_user.unit.policy
      if not @policy
        flash[:info] = "You have not set the policies for this semester. Set your policies below."
        redirect_to new_policy_path
      end
    else
      flash[:notice] = "You cannot edit the policies for this semester. Contact the workshift manager."
      redirect_to policy_path
    end
  end

  # POST /policies
  # POST /policies.json
  def create
    @policy = Policy.create!(policy_params)
    @current_user.unit.policy = @policy
    @current_user.unit.save
    flash[:success] = "Your policies have been saved."
    redirect_to policy_path
  end

  # PATCH/PUT /policies/1
  # PATCH/PUT /policies/1.json
  def update
    @policy = @current_user.unit.policy
    @policy.update_attributes!(policy_params)
    flash[:success] = "Your policies have been updated."
    redirect_to policy_path
  end

#   # DELETE /policies/1
#   # DELETE /policies/1.json
#   def destroy
#     @policy.destroy
#     respond_to do |format|
#       format.html { redirect_to policies_url, notice: 'Policy was successfully destroyed.' }
#       format.json { head :no_content }
#     end
#   end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_policy
      # @policy = Policy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def policy_params
      params.require(:policy).permit(:first_day, :last_day, :fine_amount, :fine_days, :market_sell_by)
    end
end
