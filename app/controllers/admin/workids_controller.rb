class Admin::WorkidsController < ApplicationController
  layout 'admin'
  before_filter :require_logined
  def index
    @workids = Workid.page(params[:page])
    #@workids.each do |w|
    #  channel = Channel.find w.channel_id
    #  w.channel = channel.name
    #  binding.pry
    #end
  end

  def create
    @workid = Workid.new workid_params
    if @workid.save
      redirect_to action:'index'
    else
      render 'new'
    end
  end

  def new
    @workid = Workid.new
  end

  def destroy
    @workid = Workid.find params[:id]
    @workid.destroy
    respond_with do |format|
      format.html { redirect_to action:'index' }
      format.js { render :nothing => true, :status => 200, :content_type => 'text/html' }
    end
  end

  def update_status
    @workid = Workid.find params[:id]
    if @workid.status == 0
      status = 1
    else
      status = 0
    end
    @workid.update_attribute(:status, status)
    respond_with do |format|
      format.html { redirect_to action:'index' }
      format.js { render :nothing => true, :status => 200, :content_type => 'text/html' }
    end
  end

  private
  def workid_params
    params.require(:workid).permit(:name, :password, :business_password,:day_limit, :priority, :business, :agent, :channel_id)
  end
end
