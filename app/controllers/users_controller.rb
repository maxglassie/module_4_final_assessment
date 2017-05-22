class UsersController < ApplicationController 

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Successfully signed up!"
      session[:user_id] = @user.id
      redirect_to root_path
    elsif User.exists?(['email LIKE ?', "%#{@user.email}%"])
      flash[:error] = "Email is already registered!"
      redirect_to new_user_path
    elsif password_blank?
      flash[:error] = "Password cannot be blank"
      redirect_to new_user_path
    elsif password_confirmation_blank?
      flash[:error] = "Password confirmation cannot be blank"
      redirect_to new_user_path
    elsif password_and_confirmation_equal?
      flash[:error] = "Password confirmation and password do not match"
      redirect_to new_user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def password_blank?
    params[:user][:password] == ""
  end

  def password_confirmation_blank?
    params[:user][:password_confirmation] == ""
  end

  def password_and_confirmation_equal?
    params[:user][:password] != params[:user][:password_confirmation]
  end
end