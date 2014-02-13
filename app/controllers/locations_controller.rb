class LocationsController < ApplicationController
  layout 'home'
  before_filter :require_logined

  def search
    @location = Location.find_by_number(params[:number].slice(0,7))
    render json: @location
  end

  private

end
