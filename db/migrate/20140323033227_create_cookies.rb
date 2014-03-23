class CreateCookies < ActiveRecord::Migration
  def change
    create_table :cookies do |t|

      t.string :site
      t.string :cookie
      t.string :status

      t.timestamps
    end
  end
end
