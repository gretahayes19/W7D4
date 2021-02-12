class UsersController < ApplicationController
    def new 
        @user = User.new 
        render :new
    end 

    def create 
        @user = User.new(user_params)
        if @user.save 
            redirect_to users_url
            login!(@user)
        else
            flash[:errors] = ["Password is too short (minimum is 6 characters)"]
            render :new
        end
    end 

    def show 
        if logged_in?
            @user = User.find_by(params[:id])
            render :show
        else
            redirect_to new_session_url
        end 
    end 






    def user_params 
        params.require(:user).permit(:username, :password)
    end 
end
