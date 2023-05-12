class ApplicationController < ActionController::Base
    helper_method :current_user
    private
  
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
  
    def require_login
      unless current_user
        flash[:error] = "You must be logged in to access this section."
        redirect_to login_path # or wherever you want to redirect the user
      end
    end
end
