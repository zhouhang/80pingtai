class Workid < ActiveRecord::Base
  belongs_to :channel

  serialize :business

  def self.getBusiness(business)
    biz = []
    if business.include?("1")
      biz.push("支持支付")
    end
    if business.include?("0")
      biz.push("支持查询")
    end
    bizStr = biz.join(" ")
    bizStr
  end
end
