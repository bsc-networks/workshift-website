class ShiftsController < ApplicationController
  before_action :set_shift, only: [:show, :edit, :update, :destroy]
  skip_before_filter :set_current_user

  # GET /shifts
  # GET /shifts.json
  def index
    @shifts = Shift.all
    @serializedShifts = json_shifts(@shifts)
    # puts "Shifts:"
    # puts @shifts
    # puts "End of shifts"
    if @shifts.empty?
      puts "EMPTY"
    end
    #puts @serializedShifts
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
      redirect_to '/signup'
    end
  end

  # GET /shifts/new
  def new
    @shift = Shift.new
  end

  # GET /shifts/1/edit
  def edit
  end

  # POST /shifts
  # POST /shifts.json
  def create
    @shift = Shift.new(shift_params)
    respond_to do |format|
      if @shift.save
        format.html { redirect_to @shift, notice: 'Shift was successfully created.' }
        format.json { render :show, status: :created, location: @shift }
      else
        format.html { render :new }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shifts/1
  # PATCH/PUT /shifts/1.json
  def update
    respond_to do |format|
      if @shift.update(shift_params)
        format.html { redirect_to @shift, notice: 'Shift was successfully updated.' }
        format.json { render :show, status: :ok, location: @shift }
      else
        format.html { render :edit }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
    end
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
    def set_shift
      @shift = Shift.find(params[:id])
    end

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
