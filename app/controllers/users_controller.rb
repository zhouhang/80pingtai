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
    render 'edit',layout:'home'
  end

  def update
    @user = current_user
    unless @user.authenticate(params[:user][:password_old])
      flash.now[:error] = t 'errors.messages.wrong_old_password'
      render action: 'edit',layout:'home'
      return
    end
    #if params[:user][:password_new] != params[:user][:password_confirmation]
    #  flash.now[:error] = t 'errors.messages.new_password_not_equal_confirm'
    #  render action: 'edit',layout:'home'
    #  return
    #end

    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.update_attributes(:password => params[:user][:password_new])
      logout
      redirect_to root_url
    else
      flash.now[:error] = t 'errors.messages.change_password_fail'
      render action: 'edit',layout:'home'
    end

  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end


end
