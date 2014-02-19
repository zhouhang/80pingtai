class Location < ActiveRecord::Base
  def isp_to_i
    a =[{isp: '移动',code: 0},{isp: '联通',code: 1},{isp: '电信',code: 2}].find {|a|a[:isp] == self.isp}
    a[:code]
  end

  def isp_to_pinyin
    a =[{isp: '移动',code: 'yidong'},{isp: '联通',code: 'liantong'},{isp: '电信',code: 'dianxin'}].find {|a|a[:isp] == self.isp}
    a[:code]
  end
end
