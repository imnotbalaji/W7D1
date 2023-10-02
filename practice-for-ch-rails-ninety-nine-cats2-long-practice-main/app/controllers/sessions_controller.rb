class SessionsController < ApplicationController
    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
        # goes into 'login' method in ApplicationController
        @user.reset_session_token!
        session[:session_token] = @user.session_token
    end


end

