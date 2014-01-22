class UsersController < ApplicationController
  before_filter :require_no_logined, :only => [:new,:create]

  def new
    @user = User.new :password => 1
    #@user.company = @user.build_company
    referrer = request.headers['X-XHR-Referer'] || request.referrer
    store_location referrer if referrer.present?
  end

  def create
    @user = User.new user_params
    #@user.company = Company.new company_params
    binding.pry
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

  def update_business_password
    @user = current_user
    if current_user.authenticate user_params[:business_password_old]
      if @user.update_attributes(user_params)
        redirect_to root_url and return
      end
    else
      current_user.errors.add(:business_password_old, I18n.t("errors.messages.wrong_old_business_password"))
    end
    render action: 'edit',layout:'home'
  end

  private

  def user_params
    params.require(:user).permit(:login,:name, :email, :password,:password_old, :password_confirmation, :business_password_confirmation, :business_password_old,:company_attributes =>[:name, :manager, :cell_phone,:telphone, :address])
  end

end
