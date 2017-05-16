class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(name: session_params[:name])
    session[:user_id] = @user.id  if  @user && @user.authenticate(session_params[:password])
    !!session[:user_id] ? (redirect_to user_path(@user)) : (redirect_to login_path)
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  private

  def session_params
    params.require(:user).permit(:password, :name)
  end

end
