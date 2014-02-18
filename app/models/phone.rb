class Phone < Transaction
  belongs_to :workid
  belongs_to :price
  belongs_to :channel

	def recharge
    #deduct user credit and grant commission
    Phone.transaction do
      self.user.use channel.price
      self.fee = channel.price.price - channel.price.agent_price
      self.price = channel.price
      self.workid = channel.workid
      self.status = 'completed'
      self.save!
      Object.const_get(channel.webapi.pinyin.capitalize).new().tel_recharge({number:number,obj:obj,total:total,denomination:channel.denominations})
    end

  end

end
