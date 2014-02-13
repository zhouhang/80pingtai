class Channelgroup < ActiveRecord::Base
  belongs_to :province
  belongs_to :city
  has_many :channelgroupships
  has_many :channels, :through => :channelgroupships

  def self.getChannelsOrders(channels, channelgroupships)
    channelOrders = []
    channels.each do |c|
      channelgroupships.each do |cg|
        if cg.channel_id == c.id
          channelOrders.push([c.name, cg.order])
        end
      end
    end
  end
end
