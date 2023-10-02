class UsersController < ApplicationController
    before_action :require_logout, only: [:new, :create]
    before_action :require_login, only: [:edit, :update]
    def index
        @user = User.all    
        render :index
    end 
    def show
        @user = User.find_by(id: params[:id])
        if @user
            render :show
        else
            render plain: "User Not found" 
        end 
    end 
    
    def new 
        render :new 
    end 
    def create
        @user = User.new(user_params)
        if @user.save!
            redirect_to user_url(@user)
        else 
            render @user.errors.full_messages, status: 422
        end 
    end 
    def user_params
        params.require(:user).permit(:username, :password)
    end
end
