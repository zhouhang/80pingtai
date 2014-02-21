class FundslogsController < ApplicationController

  layout 'home'
  before_filter :require_logined

  def index
    @fundslogs = Fundslog.where(:user_id => current_user.id).page(params[:page])
  end
end
