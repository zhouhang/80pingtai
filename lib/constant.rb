class Constant
  #高阳
  @gaoyang_tel_recharge = 'http://219.143.36.227:101/dealer/directfill/directFill.do'
  @gaoyang_checkstatus = 'http://219.143.36.227:101/dealer/prefill/preSearchFill.do'
  @gaoyang_production_query = 'http://219.143.36.227:101/dealer/prodquery/directProduct.do'
  @gaoyang_order_query = 'http://219.143.36.227:101/dealer/orderquery/directSearch.do'
  @gaoyang_number_area = 'http://219.143.36.227:101/dealer/accegment/accsegment.do'

  #千行
  @qianxing_game_order = 'http://ip:port/order/request.ashx'
  @qianxing_tel_recharge = 'http://ip:port/tel/request.ashx'
  @qianxing_card = 'http://ip:port/card/request.ashx'
  @qianxing_money_query = 'http://ip:port/money/query.ashx'
  @qianxing_order_query = 'http://ip:port/order/query.ashx'

  #鲲鹏
  @kunpeng_balance_query = 'http://112.125.40.180:8077/soft/searchbalance'
  @kunpeng_tel_recharge = 'http://112.125.40.180:8077/soft/onlinepay'
  @kunpeng_order_query = 'http://112.125.40.180:8077/soft/searchpaydetail'

  #易赛
  @esai_pre_recharge = 'http://www.esaipai.com/IF/EIFPHONE/CHECKPHONE'
  @esai_tel_recharge = 'http://www.esaipai.com/IF/EIFPHONE/IRechargeList_Phone'
  @esai_tel_recharge_test = 'http://www.esaipai.com/IF/EIFPHONE/IRechargeList_Phone_Test'
  @esai_order_query = 'http://www.esaipai.com/IF/EIFQUERY/IRechargeResult'
  @esai_order_query_test = 'http://www.esaipai.com/IF/EIFQUERY/IRechargeResult_Test'
  @esai_fund_query = 'http://www.esaipai.com/IF/QUERYFUND/IFund_Now'

  #鑫宇
  @xinyu_recharge = '/GetCharge.aspx'
  @xinyu_query = '/Query.aspx'

  #财付通
  @tenpay_pay = 'https://gw.tenpay.com/gateway/pay.htm'
  @tenpay_verify_notify = 'https://gw.tenpay.com/gateway/verifynotifyid.xml'
  @tenpay_order_query = 'https://gw.tenpay.com/gateway/normalorderquery.xml'
  @tenpay_refund = 'https://mch.tenpay.com/refundapi/gateway/refund.xml'
  @tenpay_refund_query = 'https://gw.tenpay.com/gateway/normalrefundquery.xml'
end