class Admin::SessionsController < Admin::ApplicationController
  before_filter :require_no_logined, :except => :destroy
  layout 'application'

  def new
  end

  def create
    staff = Staff.find_by_login(params[:session][:login].downcase)
    if staff && staff.authenticate(params[:session][:password]) && staff.is_a?(Staff)
      login_as staff
      remember_me if params[:remember_me]
      redirect_to admin_root_url
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