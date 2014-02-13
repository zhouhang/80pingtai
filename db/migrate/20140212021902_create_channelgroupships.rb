class CreateChannelgroupships < ActiveRecord::Migration
  def change
    create_table :channelgroupships do |t|
      t.integer :channel_id
      t.integer :order
      t.integer :channelgroup_id

      t.timestamps
    end
  end
end
