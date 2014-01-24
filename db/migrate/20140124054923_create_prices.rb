class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.string :name
      t.float :price
      t.float :agent_price
      t.integer :status

      t.timestamps
    end
  end
end
