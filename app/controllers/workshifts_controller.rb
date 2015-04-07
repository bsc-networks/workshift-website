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
    authorize :workshift
    days = params[:workshift].delete('day')
    days.pop # remove added empty string ('') entry
    if days.length == 0
      @workshift = Workshift.new(params[:workshift])
      flash[:alert] = 'Must select at least one day.'
      render :new
      return
    end
    days.each do |day|
      @workshift = Workshift.new(params[:workshift].merge(day: day))
      unless @workshift.save
        render :new
        return
      end
    end
    respond_with(@workshift)
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

  def reports
    authorize :workshift
    @reports = WeeklyReport.all
  end

  def download_report
    authorize :workshift
    report = WeeklyReport.find(params[:id])
    send_data report.report, type: 'text/csv; charset=utf-8; header=present',
                             disposition: "attachment; filename=#{report.title}"
  end

  def view_report
    authorize :workshift
    @report = WeeklyReport.find(params[:id])
  end

  private

  def set_workshift
    @workshift = Workshift.find(params[:id])
  end
end
