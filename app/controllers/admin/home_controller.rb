class Admin::HomeController < Admin::ApplicationController

  before_filter :require_logined

  def index

  end
end