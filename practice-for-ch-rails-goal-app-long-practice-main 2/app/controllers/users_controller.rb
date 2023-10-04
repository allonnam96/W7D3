class UsersController < ApplicationController
    def index
        @users = User.all
        render :index
    end
    def new
        render :new
    end
    def create
        @user = User.new(user_params)
        if @user
            login(@user)
            render :index
        else
            flash.now[:errors] = ["invalid user"]
            render :new , status: 422
        end
    end
    private
    def user_params
        params.require(:user).permit(:username, :password)
    end
end
