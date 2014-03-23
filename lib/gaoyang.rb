class Gaoyang

  TEL_RECHARGE = 'http://219.143.36.227:101/dealer/directfill/directFill.do'
=begin
  params_sample = {
    prodid:'5755178', #产品id
    agentid:'ipUserNumberyyyyMMddHHmmss1234', #代理商id
    backurl:'', #回调
    returntype:'2',  #1表示post返回 2表示返回XML信息
    mobilenum:'18607152803',
    source:'Auto', #代理商商城请填写esales
    command:'1', #1：发货 2：预查询
    mark: '',  #预留字段
    verifystring: '', #详见接后描述
    merchantKey:''
  }
=end

  def tel_recharge(params={})
    key_mappings = {:number => :orderid, :obj => :mobilenum, :total => 'PhoneMoney' }
    params = Hash[params.map {|k, v| [key_mappings[k], v] }]
    params.delete_if { |k, v| k.nil? }
    _params = {
                prodid:'',
                agentid:'',
                backurl:'', #回调
                returntype:'2',
                mobilenum:'',
                source:'Auto',
                command:'1',
                mark: '',
                merchantKey:''
              }
    _params = _params.merge params
    _params['verifystring'] = Digest::MD5.hexdigest(URI.encode_www_form(_params))
    uri = URI(TEL_RECHARGE)
    uri.query = URI.encode_www_form(_params)
    req = Net::HTTP::Get.new(uri.request_uri)
    p uri.request_uri
    res = Net::HTTP.start(uri.hostname, uri.port, open_timeout: 120, read_timeout: 120) {|http| http.request(req)}
    result = res.body#.force_encoding("gb2312").encode!('utf-8')
    p result
    result
  end

end