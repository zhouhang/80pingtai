# require 'tesseract'
require 'net/http'
require 'open-uri'

class Lianlian
  HOME_PAGE ="http://hubei.lianlian.com"
  LOGIN_URL = 'http://hubei.lianlian.com/login.do'
  CAPTCHA_URL = 'http://hubei.lianlian.com/topJcaptcha.do'
  # u 13407197166 p 123456  captcha_input



  def login
    uri = URI(HOME_PAGE)
    http = Net::HTTP.new(uri.host, uri.port)

    http.start { |http|
        resp = http.get(CAPTCHA_URL)
        cookie =  resp.get_fields('set-cookie').last.split('; ')[0]
        p cookie
        open("#{Rails.root}/public/lianlian.jpg", "wb") { |file|
            file.write(resp.body)
       }
    }

    uri = URI(LOGIN_URL)
    http = Net::HTTP.new(uri.host, uri.port)
    uri.query = URI.encode_www_form(Rails.configuration.lianlian_login_params)
    req = Net::HTTP::Post.new(uri.request_uri)
    res = http.request(req)

    result = res.body.force_encoding("GBK").encode!('utf-8')
    p result
    p res.get_fields('set-cookie')
    # @@cookie = res['Set-Cookie'].split('; ')[0]
    # @@cookie = res.get_fields('set-cookie').last.split('; ')[0]
  end


  def tel_recharge(params={},workid)
    key_mappings = {:number => 'OutOrderNumber', :obj => 'PhoneNumber', :total => 'PhoneMoney' }
    params = Hash[params.map {|k, v| [key_mappings[k], v] }]
    params.delete_if { |k, v| k.nil? }
    _params = { 'UserNumber'     => Rails.configuration.yisai_number,
                'InOrderNumber'  => "#{Rails.configuration.host_ip}#{Rails.configuration.yisai_number}#{Time.now.strftime('%Y%m%d%H%M%S')}1234",
                'OutOrderNumber' => '',
                'PhoneNumber'    => '',
                'Province'       => 'Auto',
                'City'           => 'Auto',
                'PhoneClass'     => 'Auto',
                'PhoneMoney'     => '',
                'SellPrice'      => 'None',
                'StartTime'      => Time.now.strftime('%Y-%m-%d %H:%M:%S'),
                'TimeOut'        => '600',
                'Sign'           => Rails.configuration.yisai_sign
              }
    _params = _params.merge params
    _params['RecordKey'] = Digest::MD5.hexdigest((_params.values.join).encode('gb2312')).upcase[0,16]
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