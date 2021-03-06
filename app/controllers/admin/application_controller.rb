class Admin::ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  respond_to :html, :json
  helper_method :logined?, :current_admin, :set_title, :form_title
  layout 'admin'


  def logined?
    current_admin.present? && current_admin.is_a?(Staff)
  end

  def login_as(user)
    session[:staff_id] = user.id
    @current_admin = user
  end

  def logout
    session.delete(:staff_id)
    @current_admin = nil
    forget_me
  end

  def current_admin
    @current_admin ||= login_from_session || login_from_cookies unless defined?(@current_admin)
    @current_admin
  end

  def require_logined
    unless logined?
      redirect_to admin_signin_url
    end
  end

  def require_no_logined
    if logined?
      redirect_to admin_root_url
    end
  end

  def set_locale
    I18n.locale = set_locale_from_user || set_locale_from_accept_language_header || I18n.default_locale
  end

  def set_locale_from_user
    current_admin.try(:locale)
  end

  def set_locale_from_accept_language_header
    request.compatible_language_from(ALLOW_LOCALE)
  end

  def forget_me
    cookies.delete(:remember_token)
  end


  def login_from_session
    if session[:staff_id].present?
      begin
        Staff.find session[:staff_id]
      rescue
        session[:staff_id] = nil
      end
    end
  end

  def login_from_cookies
    if cookies[:remember_token].present?
      if user = Staff.find_by_remember_token(cookies[:remember_token])
        session[:staff_id] = user.id
        user
      else
        forget_me
        nil
      end
    end
  end

  def remember_me
    cookies[:remember_token] = {
        :value   => current_admin.remember_token,
        :expires => 2.weeks.from_now,
        :httponly => true
    }
  end

  def set_title(title)
    @form_title = title
  end 

  def form_title
    @form_title
  end 

end