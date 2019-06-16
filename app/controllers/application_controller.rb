class ApplicationController < ActionController::Base
  helper_method :current_user

  rescue_from ActionController::RoutingError, with: :render_not_found
  rescue_from Exception, with: :render_not_found

  def current_user
    @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end

  def authorize
  	if current_user.nil?
  		flash[:danger] = "Not authorized"
  		redirect_to login_url
  	end
  end

  def raise_not_found!
    raise ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")
  end

  protected
  
    def render_not_found
      flash.now[:danger] = "Route not Found"
      error_redirect
    end

    def render_error
      flash.now[:danger] = "Internal error"
      error_redirect
    end

    def error_redirect
      if current_user
        redirect_to edit_user_path(current_user)
      else
        redirect_to login_path
      end
    end
end
