class ChargesController < ApplicationController
  layout 'home'
  before_filter :require_logined

  def new
    @charge = Charge.new
  end

  def create
    @charge = Charge.new charge_params
    @charge.user= current_user
    if @charge.save
      redirect_to @charge
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

  private

  def charge_params
    params.require(:charge).permit(:total,:total_confirmation,:desc)
  end


end
