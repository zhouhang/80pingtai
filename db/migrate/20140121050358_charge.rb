class Charge < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.float    :total
      t.text     :desc
      t.string   :status
      t.string   :pay_method
      t.string   :feedback
      t.references :user

      t.timestamps
    end
  end
end
