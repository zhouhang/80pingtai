class Price < ActiveRecord::Base
  has_many :channel


  def rate
    agent_price/price
  end
end
