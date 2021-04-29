class SessionsController < ApplicationController

  def new
    # Login form
  end

  def create
    # Actually try to login
    @form_data = params.require(:session)
    # Pull username and password from form
    @email = @form_data[:email]
    @password = @form_data[:password]
    # Authenticate
    @user = User.find_by(email: @email).try(:authenticate, @password)
    # If user exists, login and show homepage.
    if @user
      # Save this user to that user's session
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    # Log out
    # Remove the session
    reset_session
    # Redirect to login page
    redirect_to new_session_path
  end



end
