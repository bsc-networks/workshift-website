class SessionsController < ApplicationController
  skip_before_filter :set_current_user
  
  def new
    # render :page_login1
    if session[:user_id]
      redirect_to "/"
    end
  end

  def create
    user = User.find_by_email(params[:email])
    # if the user exists AND the password entered is correct
    if user && user.authenticate(params[:password])
      # save the user id inside the browser cookie. This is how we keep the user logged in when they navigate around our website.
      session[:user_id] = user.id
      redirect_to '/'
    else
      flash[:danger] = "Incorrect Please try again."
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
  
  def failure
  end

end