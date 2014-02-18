class Phone < Transaction
  belongs_to :workid
  belongs_to :price
  belongs_to :channel

	def recharge
    #find phone number location and isp
    location= Location.find_by_number(self.obj.slice(0,7))
    city= City.find_by_name location.city.split('省').last
    #find best channels group by location and isp
    channel_group = Channelgroup.best_match city.id,city.province_id,location.isp_to_i
    #choose a channel by priority
    channel = channel_group.valid_channel(total)
    # instance_eval("#{channel.webapi.pingyin}.new.send",{})

    #deduct user credit and grant commission
    Phone.transaction do
      self.user.use channel.price
      self.fee = channel.price.price - channel.price.agent_price
      self.channel = channel
      self.price = channel.price
      self.workid = channel.workid
      self.status = 'completed'
      self.save!
    end

  end

end
