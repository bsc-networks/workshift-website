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
    if current_user.workshift_manager?
      @insights = @workshift.best_assignment_candidates
    end
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
    authorize :workshift
    days = params[:workshift].delete('day')
    days.pop # remove added empty string ('') entry
    begin
      @workshift = Workshift.create_multiple(params[:workshift], days)
      respond_with(@workshift)
    rescue ArgumentError => e
      flash[:alert] = e.message
      @workshift = Workshift.new(params[:workshift])
      render :new
    end
  end

  def update
    authorize @workshift
    if params[:workshift][:user]
      @workshift.assign_worker(params[:workshift][:user])
    end
    puts %Q{#{params[:workshift]}}
    @workshift.update_attributes(params[:workshift].except(:user))
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
