class UnitsController < ApplicationController
  before_filter :set_unit, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  respond_to :html, :json

  def index
    @units = Unit.all
    respond_with(@units)
  end

  def show
    respond_with(@unit)
  end

  def new
    @unit = Unit.new
    authorize @unit
    respond_with(@unit)
  end

  def edit
    authorize @unit
  end

  def create
    logger.debug params
    @unit = Unit.new(params[:unit])
    authorize @unit
    if @unit.save
      respond_with(@unit)
    else
      render :new
    end
  end

  def update
    authorize @unit
    @unit.update_attributes(params[:unit])
    respond_with(@unit)
  end

  def destroy
    authorize @unit
    @unit.destroy
    @unit.users.each do |user|
      if not (user.admin? or user.workshift_manager?)
        user.destroy
      end
    end
    respond_with(@unit)
  end

  private

  def set_unit
    @unit = Unit.find(params[:id])
  end
end
