class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in!"
    else
      flash[:error] = "Incorrect email and/or password"
      redirect_to '/login'
    end
  end

  def destroy
    session.clear
    flash[:notice] = "Logged Out"
    redirect_to root_path
  end
end