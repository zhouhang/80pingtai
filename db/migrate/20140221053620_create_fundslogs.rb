class CreateFundslogs < ActiveRecord::Migration
  def change
    create_table :fundslogs do |t|
      t.text :desc
      t.float :money
      t.float :cur_money
      t.float :cur_commission
      t.references :staff
      t.references :user
      t.references :transaction

      t.timestamps
    end
  end
end
