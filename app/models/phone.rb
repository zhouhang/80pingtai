class Phone < Transaction
  belongs_to :workid
  belongs_to :price
  belongs_to :channel

	def recharge
    #deduct user credit and grant commission
    Phone.transaction do
      self.fee = self.total*(1-channel.price.rate).round(2) #channel.price.price - channel.price.agent_price
      self.user.use self.total-self.fee
      self.price = channel.price
      self.workid = channel.workid
      self.status = 'completed'
      location = Location.find_by_number(number.slice(0,7))
      self.location =  City.find_by_name(location.city.split('省').last).id
      self.webapi = channel.webapi
      self.save!
      self.user.grant_commission self.fee

      #capitalize
      #Object.const_get(channel.webapi.pinyin.camelize).new().tel_recharge({number:number,obj:obj,total:total.to_i,denomination:channel.denominations},self.workid)
    end

  end

  def type_display
    "手机缴费扣款"
  end

end
