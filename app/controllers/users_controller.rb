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
    if current_user.authenticate user_params[:password_old]
      if @user.update_attributes(user_params)
        logout
        redirect_to root_url and return
      end
    else
      current_user.errors.add(:password_old, I18n.t("errors.messages.wrong_old_password"))
    end
    render action: 'edit',layout:'home'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,:password_old, :password_confirmation)
  end


end
