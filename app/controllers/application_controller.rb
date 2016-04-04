# app/controllers/application_controller.rb

class ApplicationController < ActionController::Base
  before_filter :set_current_user
  protected # prevents method from being invoked by a route
  def set_current_user
    # we exploit the fact that find_by_id(nil) returns nil
    @current_user ||= User.find_by_id(session[:user_id])
    redirect_to login_path and return unless @current_user
  end
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    begin 
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue
      session[:user_id] = nil
      redirect_to login_path
    end
  end
  helper_method :current_user

  def authorize
    redirect_to '/login' unless current_user
  end
  
  def current_house
    @current_house = "Cloyne"
  end
end