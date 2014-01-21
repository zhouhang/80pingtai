class HomeController < ApplicationController

  before_filter :require_logined

  def index

  end

  def change_password_params
    params.require(:user).permit(:password_old, :password_new, :password_confirmation)
  end

end