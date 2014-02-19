class Dianxin
  LOGIN_URL = 'https://61.183.0.25:9443/insms/dealer/en/loginin.do'
  QUERY_URL = 'https://61.183.0.25:9443/insms/dealer/en/Recharge.do?case.menuid=050116&operationType=query&trans_evType=2&trans_msisdn=phone_number&trans_money=&tip_hpone=&trans_pin='
  @@cookie = nil

  def initialize
    uri = URI(LOGIN_URL)
    @https = Net::HTTP.new(uri.host, uri.port)
    @https.use_ssl = true
    @https.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end

  def query(number)
    login if @@cookie.blank?
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

  def login
    @@cookie = nil
    uri = URI(LOGIN_URL)
    uri.query = URI.encode_www_form(Rails.configuration.evc_login_params)
    req = Net::HTTP::Post.new(uri.request_uri)
    res = @https.request(req)
    result = res.body.force_encoding("gb2312").encode!('utf-8')
    # @@cookie = res['Set-Cookie'].split('; ')[0]
    @@cookie = res.get_fields('set-cookie').last.split('; ')[0]
  end
end