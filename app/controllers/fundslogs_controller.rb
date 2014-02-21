class FundslogsController < ApplicationController

  layout 'home'
  before_filter :require_logined

  def index
    @fundslogs = Fundslog.page(params[:page])
  end
end
