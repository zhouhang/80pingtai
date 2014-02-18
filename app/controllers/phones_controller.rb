class PhonesController < ApplicationController
  layout 'home'
  before_filter :require_logined

  def index
    @phones = Phone.page(params[:page])
  end

  def new
    @phone = Phone.new
  end

  def create

    @phone = Phone.new phone_params

    if(params[:phone][:business_password] != current_user.business_password)
      @phone.errors.add(:business_password, '交易密码错误')
      render action: "new" and return
    end

    if(@phone.total > current_user.credit)
      @phone.errors.add(:business_password, '账户余额不足')
      render action: "new" and return
    end

    @phone.user= current_user
    @phone.channel= Channel.find params[:phone][:channel_id]
    if @phone.recharge
      redirect_to action:'index'
    else
      render action: "new"
    end
  end

  def edit
    @charge = Charge.find params[:id]
  end

  def update
    @charge = Charge.find(params[:id])
    if @charge.update_attributes(params[:post])
      redirect_to @charge
    else
      render action: "edit"
    end
  end

  def cancel
    @charge = Charge.by_user(current_user).find params[:id]
    @charge.cancel
    respond_with do |format|
      format.html { redirect_to action:'index' }
      format.js { render :nothing => true, :status => 200, :content_type => 'text/html' }
    end
  end

  private

  def phone_params
    params.require(:phone).permit(:total,:obj)
  end


end
