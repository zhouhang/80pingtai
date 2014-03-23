require 'net/http'
class Yisai

  # TEL_RECHARGE = 'http://www.esaipai.com/IF/EIFPHONE/IRechargeList_Phone'
  TEL_RECHARGE = 'http://www.esaipai.com/IF/EIFPHONE/IRechargeList_Phone_Test'
  #Yisai.new.tel_recharge({:number => '12345677665',:obj => '18607152803', :total=>'100'})
=begin
  params_sample = {
    UserNumber:'5755178', #
    InOrderNumber:'ipUserNumberyyyyMMddHHmmss1234',
    OutOrderNumber:'', #单位面值
    PhoneNumber:'18607152803',  #充值手机号码
    Province:'Auto',
    City:'Auto',
    PhoneClass:'Auto',
    PhoneMoney: '',
    SellPrice: 'None'
    StartTime: Time.now,
    TimeOut: '600',
    RecordKey: ''
  }
=end

#Esai-178   123456789   5755178

  def tel_recharge(params={})
    key_mappings = {:number => 'OutOrderNumber', :obj => 'PhoneNumber', :total => 'PhoneMoney' }
    params = Hash[params.map {|k, v| [key_mappings[k], v] }]
    params.delete_if { |k, v| k.nil? }
    now = Time.now
    _params = { 'UserNumber'     => Rails.configuration.yisai_number,
                'InOrderNumber'  => "IP#{Rails.configuration.yisai_number}#{now.strftime('%Y%m%d%H%M%S')}1234",
                'OutOrderNumber' => '',
                'PhoneNumber'    => '',
                'Province'       => 'Auto',
                'City'           => 'Auto',
                'PhoneClass'     => 'Auto',
                'PhoneMoney'     => '',
                'SellPrice'      => 'None',
                'StartTime'      => now.strftime('%Y-%m-%d %H:%M:%S'),
                'TimeOut'        => '600',
                'Sign'           => Rails.configuration.yisai_sign
              }
    _params = _params.merge params
    _params['RecordKey'] = Digest::MD5.hexdigest((_params.values.join).encode('gb2312')).upcase[0,16]
    uri = URI(TEL_RECHARGE)
    res = Net::HTTP.post_form(uri, _params)
    result = res.body#.force_encoding("gb2312").encode!('utf-8')
    p result
    result
  end

end