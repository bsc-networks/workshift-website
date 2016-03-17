class WorkshiftController < ApplicationController

  # before_filter :authorize
  skip_before_filter :set_current_user
  
  def index
  end
  
end