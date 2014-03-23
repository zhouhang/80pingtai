class ChargesController < ApplicationController
  layout 'home'
  before_filter :require_logined
  PAY_URL = 'https://gw.tenpay.com/gateway/pay.htm'

  def index
    @charges = Charge.page(params[:page])
  end

  def new
    @charge = Charge.new
  end

  def create
    @charge = Charge.new charge_params
    @charge.user= current_user
    if @charge.save
      redirect_to action:'index'
    else
      render action: "new"
    end
  end

  def edit
    @charge = Charge.find params[:id]
  end

  def update
    @charge = Charge.find(params[:id])
    if @charge.update_attributes(params[:post])
      redirect_to @charge
    else
      render action: "edit"
    end
  end

  def cancel
    @charge = Charge.by_user(current_user).find params[:id]
    @charge.cancel
    respond_with do |format|
      format.html { redirect_to action:'index' }
      format.js { render :nothing => true, :status => 200, :content_type => 'text/html' }
    end
  end

  def get_charge_money
    charge_total = params[:total]
    result = get_charge(charge_total, 0)
    respond_with do |format|
      format.json { render :json => {'data' => result} }
    end
  end

  def get_charge(charge_total, time)
    if time <= 3
      num = rand(99)
      total = num + Integer(charge_total)
      charge = Charge.where(:total => total)
      if charge.size == 0
        total
      else
        get_charge_money(charge_total, time)
      end
    else
      "操作失败,请稍后再试"
    end
  end

  def get_tenpay_url
    @charge = Charge.new( :total => params[:total], :remark => params[:remark], :pay_method => params[:pay_method] )
    @charge.user= current_user
    if @charge.save
      paramsTen = {}
      paramsTen[:partner] = '1215786801'
      paramsTen[:input_charset] = 'GBK'
      paramsTen[:desc] = params[:remark]
      paramsTen[:return_url] = 'http://vhost:3000/charges/return'
      paramsTen[:notify_url] = 'http://vhost:3000/charges/notify'
      paramsTen[:out_trade_no] = Charge.last.id
      paramsTen[:total_fee] = params[:total]
      paramsTen[:fee_type] = '1'
      paramsTen[:key] = '0b25eba592c039a6d69838087d5d8b00'
      paramsTen[:spbill_create_ip] = request.remote_ip
      paramsTen[:time_start] = Time.new.strftime("%Y%m%d%H%M%S")
      paramsTen[:time_expire] = Time.new.strftime("%Y%m%d%H%M%S")
      status = 'success'
      url = "https://gw.tenpay.com/gateway/pay.htm?#{toStr paramsTen}"
    else
      status = 'fail'
    end
    respond_with do |format|
      format.json { render :json => {'data' => {'status'=>status, 'url'=>url}} }
    end
  end

  def toStr(params)
    params[:sign] = Digest::MD5.hexdigest "input_charset=#{params[:input_charset]}&partner=#{params[:partner]}&total_fee=#{params[:total_fee]}&key=#{params[:key]}"
    paramsArr = params.map { |k,v| "#{k}=#{v}" }
    paramsStr = "#{PAY_URL}?#{paramsArr.join("&")}"
  end

  private

  def charge_params
    params.require(:charge).permit(:total,:remark,:pay_method)
  end


end
