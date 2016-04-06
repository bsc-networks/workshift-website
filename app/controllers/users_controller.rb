class UsersController < ApplicationController

  def new
    if not @current_user.is_ws_manager?
      redirect_to '/'
    end
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
    @users_uploaded = get_current_uploaded(params[:confirmed_ids])
    if (not params[:file].blank?)
      new_users = User.import(params[:file])
      @users_uploaded += new_users
    else
      flash[:notice] = "No file specified."
      redirect_to '/signup'
    end
  end
  
  def add_user
    @users_uploaded = get_current_uploaded(params[:confirmed_ids])
    new_user = User.new
    new_user.update_attributes(user_params)
    new_user.update_attribute(:password, User.random_pw)
    new_user.save
    @users_uploaded << new_user
    render "upload"
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
  
  def upload_avatar
    @current_user.avatar = params[:user][:avatar]
    @current_user.save
    redirect_to user_profile_path
  end
  
  def show
    @user = User.find_by_id(params[:id])
  end
  
  def edit
  end
  
private

  def get_current_uploaded ids
    added = []
    if ids
      ids.each do |id|
        added << User.find(id)
      end
    end
    return added
  end
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :permissions, :password, :password_confirmation, :avatar)
  end
end