class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string 	:type

      t.string   :pay_method
      t.string   :feedback

      t.string  :obj
      t.float   :fee
      t.float   :total
      t.string  :status
      t.string  :number
      t.string  :remark
      
      t.references :user
      t.references :price
      t.references :channel
      t.references :workid
      t.references :staff
      t.timestamps
    end
  end
end
