class Admin::AnnouncementsController < Admin::ApplicationController
  layout 'admin'
  before_filter :require_logined
  def index
    @announcements = Announcement.page(params[:page])
  end

  def create
    @announcement = Announcement.new announcement_params
    if @announcement.save
      redirect_to action:'index'
    else
      render 'new'
    end
  end

  def new
    @announcement = Announcement.new
  end

  def destroy
    @announcement = Announcement.find params[:id]
    @announcement.destroy
    respond_with do |format|
      format.html { redirect_to action:'index' }
      format.js { render :nothing => true, :status => 200, :content_type => 'text/html' }
    end
  end

  def edit
    @announcement = Announcement.find params[:id]
  end

  def update
    if  Announcement.find(params[:id]).update(announcement_params)
      redirect_to action:'index'
    else
      render edit_admin_announcement_path
    end
  end

  private
  def announcement_params
    params.require(:announcement).permit(:content)
  end

end
