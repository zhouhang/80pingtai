class Channel < ActiveRecord::Base
  belongs_to :price
  belongs_to :webapi
  has_many :workid

  has_many :channelgroupships
  has_many :channelgroups, :through => :channelgroupships

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

  def self.get_channelnames(channels)
    channelnames = ""
    channels.each do |cn|
      channelnames += cn.name+","
    end
    channelnames
  end

end
