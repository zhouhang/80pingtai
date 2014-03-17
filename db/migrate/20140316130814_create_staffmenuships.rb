class CreateStaffmenuships < ActiveRecord::Migration
  def change
    create_table :staffmenuships do |t|
      t.integer :staff_id
      t.integer :menu_id

      t.timestamps
    end
  end
end
