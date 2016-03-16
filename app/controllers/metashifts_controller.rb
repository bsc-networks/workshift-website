class MetashiftsController < ApplicationController
  before_action :set_metashift, only: [:show, :edit, :update, :destroy]

  # GET /metashifts
  # GET /metashifts.json
  def index
    @metashifts = Metashift.all
  end

  # GET /metashifts/1
  # GET /metashifts/1.json
  def show
  end

  # GET /metashifts/new
  def new
    @metashift = Metashift.new
  end

  # GET /metashifts/1/edit
  def edit
  end

  # POST /metashifts
  # POST /metashifts.json
  def create
    @metashift = Metashift.new(metashift_params)

    respond_to do |format|
      if @metashift.save
        format.html { redirect_to @metashift, notice: 'Metashift was successfully created.' }
        format.json { render :show, status: :created, location: @metashift }
      else
        format.html { render :new }
        format.json { render json: @metashift.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /metashifts/1
  # PATCH/PUT /metashifts/1.json
  def update
    respond_to do |format|
      if @metashift.update(metashift_params)
        format.html { redirect_to @metashift, notice: 'Metashift was successfully updated.' }
        format.json { render :show, status: :ok, location: @metashift }
      else
        format.html { render :edit }
        format.json { render json: @metashift.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /metashifts/1
  # DELETE /metashifts/1.json
  def destroy
    @metashift.destroy
    respond_to do |format|
      format.html { redirect_to metashifts_url, notice: 'Metashift was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_metashift
      @metashift = Metashift.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def metashift_params
      params.require(:metashift).permit(:category, :description, :multiplier)
    end
end
