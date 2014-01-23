class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.string :login
      t.string :name
      t.string :password
      t.string :password_digest

      t.timestamps
    end
  end
end
