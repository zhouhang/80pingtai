class UsersController < ApplicationController
  before_filter :require_no_logined, :only => [:new,:create]

  def new
    @user = User.new :password => 1
    referrer = request.headers['X-XHR-Referer'] || request.referrer
    store_location referrer if referrer.present?
  end

  def create
    @user = User.new user_params
    if @user.save
      login_as @user
      redirect_to root_url
    else
      render action: "new"
    end
  end

  def edit
    @user = current_user
  end

  def update
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

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end


end
