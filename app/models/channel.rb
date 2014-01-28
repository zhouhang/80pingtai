class Channel < ActiveRecord::Base
  has_one :price
  has_one :webapi
  has_one :workid

  def self.get_prices
    @prices = Price.select(:name, :id).to_a
  end

  def self.get_webapi
    @webapis = Webapi.select(:name, :id).to_a
  end

  def self.get_prices_by_id(id)
    @price = Price.find(id)
  end

  def self.get_area_by_cid(cid)
    areas = City.select(:name).find_all_by_id(cid.split(","))
    names = []
    areas.each do |a|
      names.push(a.name)
    end
    names
  end

  def self.get_channels_display
    @channels = Channel.find_by_sql("select channels.*, prices.name as pname from channels left join prices on channels.price_id = prices.id")
  end

end
