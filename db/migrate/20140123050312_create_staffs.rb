class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.string :login
      t.string :name
      t.string :phone
      t.string :password
      t.string :password_digest
      t.integer :status

      t.timestamps
    end
  end
end
