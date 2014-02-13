class CreateChannelgroups < ActiveRecord::Migration
  def change
    create_table :channelgroups do |t|
      t.integer :province_id
      t.integer :city_id
      t.integer :operator_id

      t.timestamps
    end
  end
end
