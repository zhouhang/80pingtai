class Admin::ChannelsController < Admin::ApplicationController
  layout 'admin'
  before_filter :require_logined
  def index
    @channels = Channel.get_channels_display
    @channels.each do |c|
      c.area = Channel.get_area_by_cid(c.area).join(",")
    end
  end

  def new
    @channel = Channel.new
  end

  def create
    @channel = Channel.new channel_params
    if @channel.save
      redirect_to action:'index'
    else
      render 'new'
    end
  end

  def get_provinces_cities
    @cities = City.get_province_cities
    respond_with do |format|
      format.json { render :json => {'data' => [@cities]} }
    end
  end

  def update_status
    @channel = Channel.find params[:id]
    if @channel.status == 0
      status = 1
    else
      status = 0
    end
    @channel.update_attribute(:status, status)
    respond_with do |format|
      format.html { redirect_to action:'index' }
      format.js { render :nothing => true, :status => 200, :content_type => 'text/html' }
    end
  end

  def destroy
    @channel = Channel.find params[:id]
    @channel.destroy
    respond_with do |format|
      format.html { redirect_to action:'index' }
      format.js { render :nothing => true, :status => 200, :content_type => 'text/html' }
    end
  end

  private
  def channel_params
    params.require(:channel).permit(:name, :price_id, :webapi_id,:maxlimit, :minlimit, :denomination, :priority, :business, :area)
  end

end
