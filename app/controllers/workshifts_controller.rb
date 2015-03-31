class WorkshiftsController < ApplicationController
  before_filter :set_workshift, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  after_filter :verify_authorized, except: :index

  respond_to :html, :json

  def index
    @workshifts = Workshift.order(:day)
    respond_with(@workshifts)
  end

  def show
    authorize @workshift
    respond_with(@workshift)
  end

  def new
    @workshift = Workshift.new
    authorize @workshift
    respond_with(@workshift)
  end

  def edit
    authorize @workshift
  end

  def create
    @workshift = Workshift.new(params[:workshift])
    authorize @workshift
    if @workshift.save
      respond_with(@workshift)
    else
      render :new
    end
  end

  def update
    authorize @workshift
    @workshift.update_attributes(params[:workshift])
    respond_with(@workshift)
  end

  def destroy
    authorize @workshift
    @workshift.destroy
    respond_with(@workshift)
  end

  private

  def set_workshift
    @workshift = Workshift.find(params[:id])
  end
end
