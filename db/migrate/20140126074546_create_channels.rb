class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :name
      t.string :area
      t.integer :maxlimit
      t.integer :minlimit
      t.string :denomination
      t.integer :priority
      t.string :business
      t.string :other
      t.integer :status
      t.references :price
      t.references :webapi

      t.timestamps
    end
  end
end
