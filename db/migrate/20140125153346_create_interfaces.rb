class CreateInterfaces < ActiveRecord::Migration
  def change
    create_table :interfaces do |t|
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
