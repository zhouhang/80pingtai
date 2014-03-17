class Liantong

  LOGIN_URL = 'https://218.106.115.32/por/login_psw.csp?rnd=gpccmlmgaeoigpae'

  def tel_recharge(params={})
    uri = URI(LOGIN_URL)

    @https = Net::HTTP.new(uri.host, uri.port)
    @https.use_ssl = true
    @https.verify_mode = OpenSSL::SSL::VERIFY_NONE

    uri.query = URI.encode_www_form(Rails.configuration.liantong_login_params)
    req = Net::HTTP::Post.new(uri.request_uri)
    res = @https.request(req)
    uri = URI("https://218.106.115.32/por/#{res['location']}")
    req = Net::HTTP::Get.new(uri.request_uri)
    res = @https.request(req)
    result = res.body.force_encoding("gb2312").encode!('utf-8')
    p result
    result
  end

end
end