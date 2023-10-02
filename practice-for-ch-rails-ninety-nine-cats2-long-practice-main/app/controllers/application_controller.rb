class ApplicationController < ActionController::Base

    helper_method :current_user, :logged_in?
    # CHRILLL
        # Current_user
        # Helper_methods
        # Require login/logout
        # I 
        # login
        # logged_in?
        # logout

    # login
    def login(user)
        session[:session_token] = user.reset_session_token!
    end
    # require login 
    def require_login
        redirect_to new_session_url unless logged_in?
    end 
    # require logout
    def require_logout
        redirect_to users_url if logged_in?
    end 
    # current_user
    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])

    end

    # logged_in
    def logged_in?
        !!current_user
    end
        
    # logout
    def logout
        current_user.reset_session_token!
        session[:session_token] = nil
    end
end