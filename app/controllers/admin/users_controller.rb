class Admin::UsersController < Admin::ApplicationController
  layout 'admin'
  before_filter :require_logined
  def index
    @users = User.all.page(params[:page])
  end

  def member
    @users = User.where(:id =>  params[:ids].split(','))
    @users.update_all(:role => params[:role])
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    @user.update_attributes(user_params)
    redirect_to :action => 'index'
  end

  def user_params
    params.require(:user).permit(:login,:name, :email,:staff_id,:company_attributes =>[:name, :manager, :cell_phone,:telphone, :address,:province,:city])
  end

end
