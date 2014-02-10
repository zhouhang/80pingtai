class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :name
      t.string :area
      t.integer :priority
      t.string :denomination
      t.string :business
      t.string :remark
      t.integer :status
      t.references :price
      t.references :webapi

      t.timestamps
    end
  end
end
