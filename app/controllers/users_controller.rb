class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    # Form for adding new user
    @user = User.new
  end

  def create
    # Take form params, create new user
    @user = User.new(form_params)
    # If valid and saves, go to users page
    if @user.save
      session[:user_id] = @user.id
      redirect_to users_path
    else
      render 'new'
    end
  end

  def form_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
