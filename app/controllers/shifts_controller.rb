require 'chronic'
class ShiftsController < ApplicationController
  #before_action :set_shift, only: [:show, :edit, :update, :destroy]
  skip_before_filter :set_current_user

  # GET /shifts
  # GET /shifts.json
  def index
    @shifts = Shift.all
    #print(@shifts)
    @serializedShifts = json_shifts(@shifts)
    #puts(@serializedShifts)
    if @shifts.empty?
      #puts "EMPTY"
    end
    #puts @serializedShifts
  end
  
  def new_timeslots
    meta_id = params[:id]
    @metashift = (Metashift.find_by_id(meta_id))
    render 'shifts/add_timeslots'
  end
  
  def add_timeslots
    day_of_the_week = params[:shift][:dayoftheweek]
    starttime = params[:shift][:start_time]
    endtime = params[:shift][:end_time]
    metashift = Metashift.find_by_id(params[:shift][:metashift_id])
    start_time = Chronic.parse('this ' + day_of_the_week + ' ' + starttime.to_str)
    end_time = Chronic.parse('this ' + day_of_the_week + ' ' + endtime.to_str)
    a_shift = Shift.new(:start_time => start_time, :end_time => end_time)
    a_shift.save!
    metashift.shifts << a_shift
    redirect_to '/shifts'
  end

  # GET /shifts/1
  # GET /shifts/1.json
  def show
  end
  
  def upload
    if (not params[:file].blank?)
      new_shifts = Metashift.import(params[:file])
      @metashifts_uploaded = new_shifts
    else
      flash[:notice] = "No file specified."
      redirect_to '/shifts/new'
    end
  end

  # GET /shifts/new
  def new
    @shift = Shift.new
  end

  # GET /shifts/1/edit
  def edit
  end


  # PATCH/PUT /shifts/1
  # PATCH/PUT /shifts/1.json
  def update
    # respond_to do |format|
    #   if @shift.update(shift_params)
    #     format.html { redirect_to @shift, notice: 'Shift was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @shift }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @shift.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /shifts/1
  # DELETE /shifts/1.json
  def destroy
    @shift.destroy
    respond_to do |format|
      format.html { redirect_to shifts_url, notice: 'Shift was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    #def set_shift
    #  @shift = Shift.find(params[:id])
    #end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shift_params
      params.require(:shift).permit(:start_time, :end_time, :metashift_id)
    end
    
    #Keys: shift, user, start_time, end_time, description
    def json_shifts(instances)
      lst = []
      instances.each do |shift|
        lst << shift.full_json
      end
      lst
    end 
end
