class Admin::PricesController < ApplicationController
  layout 'admin'
  before_filter :require_logined
  def index
    @prices = Price.page(params[:page])
  end

  def edit
    @price = Price.find params[:id]
  end

  def update

  end

  def create
    @price = Price.new price_params
    if @price.save
      redirect_to action:'index'
    else
      render 'new'
    end
  end

  def show

  end

  def new
    @price = Price.new
  end

  def destroy
    @price = Price.find params[:id]
    @price.destroy
    respond_with do |format|
      format.html { redirect_to action:'index' }
      format.js { render :nothing => true, :status => 200, :content_type => 'text/html' }
    end
  end

  def update_status
    @price = Price.find params[:id]
    if @price.status == 0
      status = 1
    else
      status = 0
    end
    @price.update_attribute(:status, status)
    respond_with do |format|
      format.html { redirect_to action:'index' }
      format.js { render :nothing => true, :status => 200, :content_type => 'text/html' }
    end
  end

  private
  def price_params
    params.require(:price).permit(:name, :price, :agent_price,:status)
  end
end
