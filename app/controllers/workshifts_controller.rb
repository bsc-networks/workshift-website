class WorkshiftsController < ApplicationController
  before_filter :set_workshift, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  respond_to :html, :json

  def index
    @workshifts = Workshift.order(:day)
    respond_with(@workshifts)
  end

  def show
    respond_with(@workshift)
  end

  def new
    @workshift = Workshift.new
    respond_with(@workshift)
  end

  def edit
  end

  def create
    @workshift = Workshift.new(params[:workshift])
    if @workshift.save
      respond_with(@workshift)
    else
      render :new
    end
  end

  def update
    @workshift.update_attributes(params[:workshift])
    respond_with(@workshift)
  end

  def destroy
    @workshift.destroy
    respond_with(@workshift)
  end

  private

  def set_workshift
    @workshift = Workshift.find(params[:id])
  end
end
