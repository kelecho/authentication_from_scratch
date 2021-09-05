class SessionsController < ApplicationController
  skip_before_action :authenticate_user!
  
  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user.nil?
      sleep rand(200..300) / 1000.0
      flash.new.alert = "Email o Password incorrectos"
      render :new
    elsif
      @user&.authenticate(params[:password])
      session[:user_id] = @user.id
    else
      flash.new.alert = "Email o Password incorrectos"
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: 'Logged out!'
  end
end
