class SessionsController < ApplicationController

  # GET /sessions/new
  def new
  end

  # POST /sessions
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      cookies[:auth_token] = user.auth_token
      flash[:success] = "Logged in!"
      redirect_to edit_user_path(user)
    else
      flash.now[:danger] = "Email or password is invalid"
      render :new
    end
  end

  # DELETE /sessions
  def destroy
    cookies.delete(:auth_token)
    flash[:success] = "Logged out!"
    redirect_to login_url
  end
end
