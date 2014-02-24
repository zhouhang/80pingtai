class CreditsController < ApplicationController
  layout 'home'
  before_filter :require_logined

  def index
    @user = User.new
  end

  def commission_to_credit
    account = params[:account]
    money = params[:money].to_f
    business_password = params[:business_password]
    if User.where(:login => account).empty?
      status = '输入的账户不存在,请重新输入'
    end
    if money <= 0
      status = '输入的金额必须大于0'
    end
    if money > current_user.commission
      status = '输入的金额大于用户余额,请重新输入'
    end
    if User.where("business_password = ? and id = ?", business_password, current_user.id).empty?
      status = '交易比较不正确,请重新输入'
    end
    if status.nil?
      user = User.find(current_user.id)
      user.increment!(:credit, money)
      user.decrement!(:commission, money)
      status = 1
      fundslog = Fundslog.new(:desc=>'佣金转余额',:money=>money,:cur_money=>current_user.credit,:cur_commission=>current_user.commission,:staff_id=>current_user.id,:user_id=>current_user.id,:transaction_id=>0)
      fundslog.save
    end

    respond_with do |format|
      format.json { render :json => {'data' => status} }
    end
  end
end
