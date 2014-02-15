class Admin::PricesController < Admin::ApplicationController
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

  def getByKeyword
    @keyword = params[:keyword]
    @prices = Price.where("name like  '%#{@keyword}%'").page(params[:page])
    render 'index'
  end

  def edit
    @price = Price.find params[:id]
  end

  def update
    if  Price.find(params[:id]).update(price_params)
      redirect_to action:'index'
    else
      render edit_admin_price_path
    end
  end

  private
  def price_params
    params.require(:price).permit(:name, :price, :agent_price, :member_price, :status)
  end
end
