class HomeController < ApplicationController

  before_filter :require_logined

  def index

  end
end