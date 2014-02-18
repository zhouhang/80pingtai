class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string 	:type
      t.string  :obj
      t.float   :fee
      t.float   :total
      t.string  :status
      t.string  :number
      
      t.references :user
      t.references :price
      t.references :channel
      t.references :workid
      t.timestamps
    end
  end
end
