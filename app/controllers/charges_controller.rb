class ChargesController < ApplicationController
  layout 'home'
  before_filter :require_logined

  def index
    @charges = Charge.page(params[:page])
  end

  def new
    @charge = Charge.new
  end

  def create
    @charge = Charge.new charge_params
    @charge.user= current_user
    if @charge.save
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

  def charge_params
    params.require(:charge).permit(:total,:total_confirmation,:desc,:pay_method)
  end


end
