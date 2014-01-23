class SessionsController < ApplicationController

  before_filter :require_no_logined, :except => :destroy

  def new
  end

  def create
    user = User.find_by_login(params[:session][:login].downcase)
    #后台用户禁止使用前台
    if user && user.authenticate(params[:session][:password]) && user.is_a?(User)
      login_as user
      remember_me if params[:remember_me]
      redirect_to root_url
    else
      flash.now[:error] = t 'errors.messages.wrong_name_or_password'
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to root_url
  end
end