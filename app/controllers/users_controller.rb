class UsersController < ApplicationController
  before_action :user_permissions, only: [:edit, :update]

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(sign_in_params)
    if @user.save
      flash[:success] = 'User was successfully created.'
      redirect_to edit_user_path(@user)
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(edit_params)
      flash[:success] = 'User was successfully updated.'
    end
    render :edit
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def user_permissions
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sign_in_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

    # Only allow a trusted parameter "white list" through.
    def edit_params
      params.require(:user).permit(:password, :password_confirmation, :username)
    end
end
