class Channelgroupship < ActiveRecord::Base
  belongs_to :channel
  belongs_to :channelgroup
end
