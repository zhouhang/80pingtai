class Phone < Transaction
	def recharge
		location= Location.find_by_number(self.obj.slice(0,7))
		city= City.find_by_name location.city.split('省').last
		channel= Channel.where("status = '1' and area like ? ","%,#{city.id},%").order("created_at ASC").first
		current_user.grant_fee (channel.price - channel.price.agent_price)
	end
end
