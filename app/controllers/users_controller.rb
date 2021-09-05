class UsersController < ApplicationController
    skip_before_action :authenticate_user!

    def new
        @user = User.new
    end

    def create
        @user = User.new(signup_params)
        if @user.save
            session[:user_id] = @user.id
            #call out mail job
            redirect_to root_path, notice: 'Gracias por su registro!'
        else
            render :new
        end
    end
    

    private

    def signup_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
    
    

end
