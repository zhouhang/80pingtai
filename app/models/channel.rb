class Channel < ActiveRecord::Base
  belongs_to :price
  belongs_to :webapi
  has_one :workid

  has_many :channelgroupships
  has_many :channelgroups, :through => :channelgroupships

  before_save :set_default_status


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

  def workid_capable?(total)
    workid.day_limit - total >= Phone.where("workid_id = ? and DATE(created_at) = ?", workid.id, Date.today).sum(:total)
  end

  def denominations
    denomination.blank? ? '10,20,30,50,100,200,300,500,任意充': denomination
  end

  def set_default_status
    if self.status.blank?
      self.status = 1
    end
  end

end
