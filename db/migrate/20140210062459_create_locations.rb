class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
    	t.string :number
    	t.string :city
    	t.string :isp
    	t.string :zip_code

      t.timestamps
    end
  end
end
