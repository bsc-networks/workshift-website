class WorkshiftsController < ApplicationController
  before_filter :set_workshift, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  after_filter :verify_authorized, except: :index

  respond_to :html, :json

  def index
    @workshifts = Workshift.where(unit_id: current_user.unit)
    respond_with(@workshifts)
  end

  def show
    authorize @workshift
    if current_user.workshift_manager?
      @insights = @workshift.best_assignment_candidates(current_user.unit)
    end
    respond_with(@workshift)
  end

  def new
    @workshift = Workshift.new
    @workshift.unit_id = current_user.unit
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
    if days.length == 0
      @workshift = Workshift.new(params[:workshift].except(:user))
      flash[:alert] = 'Must select at least one day.'
      render :new
      return
    end

    if days.include? "7"
      days = ["0", "1", "2", "3", "4", "5", "6"]
    end

    days.each do |day|
      @workshift = Workshift.new(params[:workshift].except(:user).merge(day: day))
      unless @workshift.save
        render :new
        return
      end
      if params[:workshift][:user]
        @workshift.assign_worker(params[:workshift][:user])
      end
    end
    respond_with(@workshift)
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
