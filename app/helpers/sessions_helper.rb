module SessionsHelper

  def logined?
    !!current_user
  end

  def login_as(user)
    session[:user_id] = user.id
    @current_user = user
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
    forget_me
  end

  def current_user
    @current_user ||= login_from_session || login_from_cookies unless defined?(@current_user)
    @current_user
  end

  def require_logined
    unless logined?
      redirect_to signin_url
    end
  end

  def require_no_logined
    if logined?
      redirect_to root_url
    end
  end

  def set_locale
    I18n.locale = set_locale_from_user || set_locale_from_accept_language_header || I18n.default_locale
  end

  def set_locale_from_user
    current_user.try(:locale)
  end

  def set_locale_from_accept_language_header
    request.compatible_language_from(ALLOW_LOCALE)
  end

  def forget_me
    cookies.delete(:remember_token)
  end


  def login_from_session
    if session[:user_id].present?
      begin
        User.find session[:user_id]
      rescue
        session[:user_id] = nil
      end
    end
  end

  def login_from_cookies
    if cookies[:remember_token].present?
      if user = User.find_by_remember_token(cookies[:remember_token])
        session[:user_id] = user.id
        user
      else
        forget_me
        nil
      end
    end
  end

  def remember_me
    cookies[:remember_token] = {
        :value   => current_user.remember_token,
        :expires => 2.weeks.from_now,
        :httponly => true
    }
  end
end