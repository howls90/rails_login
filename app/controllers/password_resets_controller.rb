class PasswordResetsController < ApplicationController
  before_action :set_password_reset_token, only: [:edit, :update]

  # GET /password_reset/new
  def new
  end

  # POST /password_reset
  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    flash[:success] = "Email sent with password reset instruction."
    redirect_to login_url
  end

  # GET /password_reset/:token/edit
  def edit
  end

  # PATCH/PUT /password_reset/:token
  def update
    if @user.password_reset_at < 6.hours.ago
      flash[:danger] = "Password reset has expired."
      redirect_to new_password_reset_path
    elsif @user.update(reset_password_params) && !@user.password.blank?
      @user.password_reset_token = nil
      @user.save
      flash[:success] = "Password has been reset!"
      redirect_to login_url
    elsif @user.password.blank?
      flash.now[:danger] = "Fields can not be blank"
      render :edit
    else
      render :edit
    end
  end

  private
    def set_password_reset_token
      @user = User.find_by_password_reset_token!(params[:token])
    end

    def reset_password_params
      params.require(:user).permit(:password, :password_confirmation)
    end
end
