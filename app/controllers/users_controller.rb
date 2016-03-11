class UsersController < ApplicationController

  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/signup'
    end
  end
  
  def upload
    @users_uploaded = User.import(params[:file])
  end
  
  def get_all
    respond_to do |format|
      format.html
      format.json { render json: UserDatatable.new(view_context) }
    end
  end
  
  def confirm_users
    params[:confirmed_ids].each do |id|
      User.send_confirmation(id)
    end
    flash[:success] =  "Sent confirmation email to users!" 
    redirect_to get_all_users_path
  end
  
  
    

private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :permissions, :password, :password_confirmation)
  end
end