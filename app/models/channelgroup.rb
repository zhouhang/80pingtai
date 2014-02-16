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
  
  # scope :by_operator, ->(){
  #   where(["operator_id = ?",operator_id])
  # }

  scope :by_city, ->(city_id,operator_id){
    where(city_id: city_id, operator_id: operator_id)
  }

  scope :by_province, ->(province_id,operator_id){
    where(province_id: province_id, operator_id: operator_id)
  }

  def self.best_match(city_id,province_id,operator_id)
    a = self.by_city(city_id,operator_id).take
    return a if a.present? 

    a = self.by_province(province_id,operator_id).take
    return a if a.present? 

    a = self.by_province(0,operator_id).take
    return a if a.present? 
  end

  def valid_channel(total)
    _channels = channelgroupships.order(order: :asc).inject([]){|r,c|r << c.channel}
    _channels.select{|c|c.status == 1 and c.workid_capable?(total)}.first
  end

end
