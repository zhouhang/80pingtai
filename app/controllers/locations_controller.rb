class LocationsController < ApplicationController
  layout 'home'
  before_filter :require_logined

  def search
    location = Location.find_by_number(params[:number].slice(0,7))
    render :nothing => true, :status => 200, :content_type => 'text/html' and return  if location.blank?
    #find phone number location and isp
    city= City.find_by_name location.city.split('省').last
    #find best channels group by location and isp
    channel_group = Channelgroup.best_match city.id,city.province_id,location.isp_to_i
    #choose a channel by priority
    channel = channel_group.valid_channel
    channel.denomination = channel.denominations

    render json: {location: location, channel: channel}
  end

  private

end
