class CreateWorkids < ActiveRecord::Migration
  def change
    create_table :workids do |t|
      t.string :name
      t.string :password
      t.string :business_password
      t.integer :priority
      t.string :day_limit
      t.string :ext1
      t.string :ext2
      t.string :business
      t.integer :status
      t.references :channel

      t.timestamps
    end
  end
end
