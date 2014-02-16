class Admin::ChannelsController < Admin::ApplicationController
  layout 'admin'
  before_filter :require_logined
  def index
    @channels = Channel.get_channels_display
    @webapis = Webapi.all
    @prices = Price.all
    @channels.each do |c|
      c.area = Channel.get_area_by_cid(c.area).join(",")
      price = Price.find c.price_id
      c.pname = price.name
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
    @cities = City.get_province_cities params[:cityids]
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

  def getByCondition
    keyword = params[:keyword]
    interface = params[:interface]
    price = params[:price]
    status = params[:status]
    sql = "select * from channels  where "
    condition = [];
    if !keyword.blank?
      condition.push(" name like '%#{keyword}%'")
    end
    if !interface.blank?
      condition.push(" webapi_id = #{interface}")
    end
    if !price.blank?
      condition.push(" price_id = #{price}")
    end
    if !status.blank?
      condition.push(" status = #{status}")
    end
    conditionStr = condition.join(" and ")
    @channels = Channel.find_by_sql(sql+conditionStr)
    @channels.each do |c|
      c.area = Channel.get_area_by_cid(c.area).join(",")
    end

    @webapis = Webapi.all
    @prices = Price.all
    render 'query'
  end

  def edit
    @channel = Channel.find params[:id]
  end

  def update
    if  Channel.find(params[:id]).update(channel_params)
      redirect_to action:'index'
    else
      render edit_admin_channel_path
    end
  end

  private
  def channel_params
    params.require(:channel).permit(:name, :price_id, :webapi_id, :denomination, :operator_id, :business, :remark, :area)
  end

end
