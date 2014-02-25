class Admin::PhonesController < Admin::ApplicationController
  layout 'admin'
  before_filter :require_logined
  def index
    binding.pry
    if params[:phone]
      @phones = Phone.where("DATE(created_at) = ?",params[:phone][:created_at]).page(params[:page])
    else
      @phones = Phone.page(params[:page])
    end
    #@charges = Charge.page(params[:page])
  end

  def query

  end
end