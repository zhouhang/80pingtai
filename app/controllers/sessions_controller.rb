class SessionsController < ApplicationController

  before_filter :require_no_logined, :except => :destroy

  def new
  end

  def create
    user = User.find_by_name(params[:session][:name].downcase)
    if user && user.authenticate(params[:session][:password])
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