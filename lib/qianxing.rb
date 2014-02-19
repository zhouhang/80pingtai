class Qianxing

# 游戏和话费下单地址 http://api.18pingtai.cn:8091/order/request.ashx
# 话费专用下单地址 http://api.18pingtai.cn:8091/tel/request.ashx
# 游戏和话费查询地址 http://api.18pingtai.cn:8091/order/query.ashx


  GAME_ORDER = 'http://api.18pingtai.cn:8091/order/request.ashx'
  TEL_RECHARGE = 'http://api.18pingtai.cn:8091/tel/request.ashx'
  ORDER_QUERY = 'http://api.18pingtai.cn:8091/order/query.ashx'
  CARD = 'http://api.18pingtai.cn:8091/card/request.ashx'
  MONEY_QUERY = 'http://api.18pingtai.cn:8091/money/query.ashx'


=begin
  params_sample = {
    oid:'111', #自己订单id
    cid:'ljfc',
     pr:'20', #单位面值
     nb:'1',  #商品数量
     fm:'20', #充值金额
     pn:'18607152803', #充值号码
     ru:'http://127.0.0.1/Test/UrlReturnTest.jsp'
  }
=end

  def tel_recharge(params={})
    key_mappings = {number: :oid, obj: :pn, total: :fm}
    params = Hash[params.map {|k, v| [key_mappings[k], v] }]
    params[:pr] = params[:fm]
    params.delete_if { |k, v| k.nil? }
    _params = {oid:'0',cid:Rails.configuration.qianxing_cid,pr:'',nb:'1',fm:'',pn:'',ru:'http://59.172.87.107:4000/notify/qianxing',tsp:Time.now.strftime('%Y%m%d%H%M%S')}
    _params = _params.merge params
    _params[:sign] = Digest::MD5.hexdigest((_params.values.join+'T0DRVN2V22606608R2L2H4600TJ42H86').encode('gb2312'))#.upcase
    p _params
    uri = URI(TEL_RECHARGE)
    uri.query = URI.encode_www_form(_params)
    req = Net::HTTP::Get.new(uri.request_uri)
    p uri.request_uri
    res = Net::HTTP.start(uri.hostname, uri.port, open_timeout: 120, read_timeout: 120) {|http| http.request(req)}
    result = res.body.force_encoding("gb2312").encode!('utf-8')
    p result
    result
  end

end