class PoliciesController < ApplicationController
  before_action :set_policy, only: [:show, :edit, :update, :destroy]

  # GET /policies/1
  # GET /policies/1.json
  def show
    #if there is no policy for @current_house
      #redirect to new_policy_path
    #else
      #set @policy = policy for @current_house
    #end
    
    @policy = Policy.all.last
    # @policy = nil
    if not @policy
      if @current_user.is_ws_manager
        redirect_to new_policy_path
      else
        flash[:notice] = "The policies have not been set for this semester"
        redirect_to '/'
      end
    end
  end

  # GET /policies/new
  def new
    @policy = Policy.new
  end

  # GET /policies/1/edit
  def edit
    if @current_user.is_ws_manager
      @policy = Policy.all.last
    else
      redirect_to policy_path
    end
  end

  # POST /policies
  # POST /policies.json
  def create
    @policy = Policy.create!(policy_params)
    flash[:notice] = "Your policies have been saved"
    redirect_to policy_path
  end

  # PATCH/PUT /policies/1
  # PATCH/PUT /policies/1.json
  def update
    @policy = Policy.all.last
    @policy.update_attributes!(policy_params)
    flash[:notice] = "Your policies have been updated"
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
