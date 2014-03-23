require 'net/http'
class Admin::CookiesController < Admin::ApplicationController
  layout 'admin'
  before_filter :require_logined

  LIANLIAN ="http://hubei.lianlian.com"
  LIANLIAN_LOGIN = 'http://hubei.lianlian.com/login.do'
  LIANLIAN_CAPTCHA = 'http://hubei.lianlian.com/topJcaptcha.do'

  def index
    @workids = Workid.where id: 3

    @workids.each do |w|
      uri = URI(LIANLIAN)
      http = Net::HTTP.new(uri.host, uri.port)

      http.start { |http|
          resp = http.get(LIANLIAN_CAPTCHA)
          cookie =  resp.get_fields('set-cookie').last.split('; ')[0]
          w.ext2 = cookie
          open("#{Rails.root}/public/#{w.name}.jpg", "wb") { |file|
              file.write(resp.body)
         }
      }
    end
  end

  def login
    binding.pry
    workid = Workid.find params[:workid_id]
    cookie = params[:cookie]
    _params = {'code' => workid.name,'passWord' => workid.password, 'captcha_input' => params[:captcha] }
    uri = URI(LIANLIAN_LOGIN)
    res = Net::HTTP.post_form(uri, _params,{'Cookie' => cookie})
    result = res.body
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

  def login


  end

end
