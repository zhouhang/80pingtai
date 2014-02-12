class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  respond_to :html, :json
  helper_method :logined?, :current_user, :set_title, :form_title
  include SessionsHelper

  def set_title(title)
    @form_title = title
  end 

  def form_title
    @form_title
  end 
end
