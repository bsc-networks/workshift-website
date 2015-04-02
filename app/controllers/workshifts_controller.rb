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

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    msg = 'You are not authorized to perform this action.'
    flash[:alert] = I18n.t "pundit.#{policy_name}.#{exception.query}",
                           default: msg
    redirect_to request.referrer || root_url
  end
end
