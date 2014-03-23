class Dianxin
  LOGIN_URL    = 'https://61.183.0.25:9443/insms/dealer/en/loginin.do'
  QUERY_URL    = 'https://61.183.0.25:9443/insms/dealer/en/Recharge.do?case.menuid=050116&operationType=query&trans_evType=2&trans_msisdn=phone_number&trans_money=&tip_hpone=&trans_pin='
  TEL_RECHARGE = 'https://61.183.0.25:9443/insms/dealer/en/Recharge.do?case.step=2'
  @@cookie = nil

  def initialize
    uri = URI(LOGIN_URL)
    @https = Net::HTTP.new(uri.host, uri.port)
    @https.use_ssl = true
    @https.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end

=begin
  case.internal.step:2
  case.hidden.always:OPERATOR_LOG_ID
  OPERATOR_LOG_ID:139506759904711
  case.hidden.always:case.menuid
  case.menuid:050116
  save_trans_msisdn:153 4220 4491
  flagone:0
  flagtwo:1
  rateofexchange:100
  ratejs:2
  hp_no:371603042
  amount:245.6
  number_limit:11
  sys_max_rech:999999999
  trans_evType:2
  trans_msisdn:153 4220 4491
  trans_money:99
  trans_evBalancetype:0
  tip_hpone:15342204491
  WHERE_EV_DL_MASTER_MESSAGE:0
  trans_pin:148874
  minbase:1
  pin_min_len:4
  pin_max_len:30
=end

   def tel_recharge(params={})
    login if @@cookie.blank?

    number = params[:number]
    number = "#{number[0,3]} #{number[3,4]} #{number[7,4]}"

    _params = {'case.internal.step' => '2', 'case.hidden.always' => 'OPERATOR_LOG_ID', 'OPERATOR_LOG_ID' =>'139506759904711',
                    'case.hidden.always' => 'case.menuid', 'case.menuid' => '050116', 'flagone'=> 0, 'flagtwo' => 1,
                    'rateofexchange' => 100, 'ratejs' => 2, 'hp_no' => '371603042', 'number_limit' => 11, 'sys_max_rech' => '999999999',
                     'trans_evType' => 2, 'trans_evBalancetype' => 0, 'WHERE_EV_DL_MASTER_MESSAGE' => 0,'trans_pin' => '148874',
                     'minbase' => 1, 'pin_min_len' => 4, 'pin_max_len' => 30, 'save_trans_msisdn' =>number, 'trans_msisdn' => number,
                     'tip_hpone' => params[:number], 'trans_money' => params[:total]}

    uri = URI(TEL_RECHARGE)
    p _params
    uri.query = URI.encode_www_form(_params)
    req = Net::HTTP::Post.new(uri.request_uri,{'Cookie' => @@cookie})
    res = @https.request(req)
    result = res.body.force_encoding("gb2312").encode!('utf-8')
    p result
    result
  end

  def query(number,workid)
    login(workid) if @@cookie.blank?
    uri = URI(QUERY_URL.gsub('phone_number',number))
    req = Net::HTTP::Get.new(uri,{'Cookie' => @@cookie})
    res = @https.request(req)
    result = res.body.force_encoding("gb2312").encode!('utf-8')
    doc = Nokogiri::HTML.parse result
    spans = doc.css("span").select{|link| link['class'] == "td2"}
    if spans.blank? or spans.first.blank?
      @@cookie = nil if doc.css('title').text != '充值' #登录失败或session失效
      return {name:'',balance:''}
    end
    { name:spans.first.text,balance:spans.last.text }
  end

  def login(workid)
    @@cookie = nil
    uri = URI(LOGIN_URL)
    uri.query = URI.encode_www_form( {passWord:workid.password,userName:workid.name, loginModel:'0',language:'zh',x:'30',y:'11'})
    req = Net::HTTP::Post.new(uri.request_uri)
    res = @https.request(req)
    result = res.body.force_encoding("gb2312").encode!('utf-8')
    # @@cookie = res['Set-Cookie'].split('; ')[0]
    @@cookie = res.get_fields('set-cookie').last.split('; ')[0]
  end
end