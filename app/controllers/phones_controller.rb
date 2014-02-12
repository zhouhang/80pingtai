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

    #todo find channel,calculate price and fee,grand fee to user
    #l =location.find(:number,phone_params[:obj])
    #c = channels.find_by_location l 
    #c = c.sort_by_priority.first
    #current_user.grant_fee (c.price - c.price.agent_price)
    #c.workids.avaiable means status == 1
    # c.workids.avaiable.sort_by_priority.each |w| do
      # adjust day_limit
    # end
    #auth buz password
    @phone.user= current_user
    if @phone.save
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
