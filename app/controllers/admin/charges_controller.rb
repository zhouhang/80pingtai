class Admin::ChargesController < Admin::ApplicationController
  layout 'admin'
  before_filter :require_logined
  def index
    @charges = Charge.where(:status => 'awaiting').page(params[:page])
  end

  def confirm
    @charge = Charge.find params[:id]
    @charge.confirm current_admin
    respond_with do |format|
      format.html { redirect_to action:'index' }
      format.js { render :nothing => true, :status => 200, :content_type => 'text/html' }
    end
  end
end