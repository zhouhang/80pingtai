class Admin::PhonesController < Admin::ApplicationController
  layout 'admin'
  before_filter :require_logined
  def index
    if params[:phone]
      @phones = Phone.where("DATE(created_at) >= ? and DATE(created_at) <= ?",params[:phone][:start],
                            params[:phone][:end]).page(params[:page])
    else
      @phones = Phone.page(params[:page])
    end
    #@charges = Charge.page(params[:page])
  end

  def query

  end
end