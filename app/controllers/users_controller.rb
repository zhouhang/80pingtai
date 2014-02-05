class UsersController < ApplicationController
  before_filter :require_no_logined, :only => [:new,:create]

  def new
    @user = User.new :password => 1
    #@user.company = @user.build_company
    referrer = request.headers['X-XHR-Referer'] || request.referrer
    # store_location referrer if referrer.present?
  end

  def create
    @user = User.new user_params
    #@user.company = Company.new company_params
    if @user.valid?
      @user.staff = Staff.find @user.staff_id
      @user.save
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
    query = User.where("business_password = ? and id = ?", user_params[:business_password_old], current_user.id)
    if !query.empty?
      if user_params[:business_password] == user_params[:business_password_confirmation]
        if @user.update_attribute(:business_password, user_params[:business_password])
          redirect_to root_url and return
        end
      else
        current_user.errors.add(:business_password, I18n.t("errors.messages.new_password_not_equal_confirm"))
      end
    else
      current_user.errors.add(:business_password_old, I18n.t("errors.messages.wrong_old_business_password"))
    end
    render action: 'edit',layout:'home'
  end

  private

  def user_params
    params.require(:user).permit(:login,:name, :email, :password,:password_old, :password_confirmation, :business_password, :business_password_confirmation, :business_password_old,:staff_id,:company_attributes =>[:name, :manager, :cell_phone,:telphone, :address,:province,:city])
  end

end
