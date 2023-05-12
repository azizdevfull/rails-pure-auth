class UsersController < ApplicationController
  before_action :redirect_signed_in_user, only: [:new, :create, :login, :authenticate]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "You have successfully registered."
    else
      render :new
    end
  end

  def login
    @user = User.new
  end

  def authenticate
    user = User.find_by(email: params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "You have successfully logged in."
    else
      @user = User.new(email: params[:user][:email])
      flash[:error] = "Invalid email or password."
      redirect_to login_path
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path, notice: "You have successfully logged out."
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def redirect_signed_in_user
    if current_user
      redirect_to root_path, alert: "You are already signed in."
    end
  end

end
