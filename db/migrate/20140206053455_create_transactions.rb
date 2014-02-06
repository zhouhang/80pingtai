class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string 	:type
      t.string  :obj
      t.float   :fee
      t.float   :total
      t.string  :status
      t.references :user
      t.timestamps
    end
  end
end
