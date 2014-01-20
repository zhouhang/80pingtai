class HomeController < ApplicationController

  before_filter :require_logined

  def index

  end

  def edit_password
    @user = User.new
  end

  def update_password
    @user = User.find(session[:user_id])
    password_old = params.require(:user).permit(:password_old)
    if !@user || !@user.authenticate(params[:user][:password_old])
      flash.now[:error] = t 'errors.messages.wrong_name_or_password'
      render action: 'edit_password'
    end
    if params[:user][:password_old] != params[:user][:password_confirmation]
      flash.now[:error] = t 'errors.messages.wrong_name_or_password'
      render action: 'edit_password'
    end

    #if @user.update()

    redirect_to root_url
  end

  def change_password_params
    params.require(:user).permit(:password_old, :password_new, :password_confirmation)
  end

end