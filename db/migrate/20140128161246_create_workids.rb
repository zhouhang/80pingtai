class CreateWorkids < ActiveRecord::Migration
  def change
    create_table :workids do |t|
      t.string :name
      t.string :password
      t.string :business_password
      t.integer :priority
      t.string :day_limit
      t.string :business
      t.integer :status
      t.integer :channel_id

      t.timestamps
    end
  end
end
