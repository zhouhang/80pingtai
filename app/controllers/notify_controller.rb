class NotifyController < ApplicationController
  def qianxing
    p params
    render :nothing => true, :status => 200, :content_type => 'text/html' 
  end
end