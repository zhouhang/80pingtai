class UsersController < ApplicationController
  before_filter :require_no_logined

  def new
    @user = User.new :password => 1
    referrer = request.headers['X-XHR-Referer'] || request.referrer
    store_location referrer if referrer.present?
  end

  def create
    @user = User.new user_params
    if @user.save
      login_as @user
      render layout: 'home'
    else
      render action: "new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end


end
