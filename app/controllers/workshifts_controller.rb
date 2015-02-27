class WorkshiftsController < ApplicationController
  before_filter :set_workshift, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @workshifts = Workshift.all
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
    @workshift.save
    respond_with(@workshift)
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
