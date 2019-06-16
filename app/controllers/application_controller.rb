class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end

  def authorize
  	if current_user.nil?
  		flash[:danger] = "Not authorized"
  		redirect_to login_url
  	end
  end
end
