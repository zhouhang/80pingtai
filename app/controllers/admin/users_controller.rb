class Admin::UsersController < Admin::ApplicationController
  layout 'admin'
  before_filter :require_logined
  def index
    @users = User.all.page(params[:page])
  end

end
