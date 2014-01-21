class User < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :password_digest
      t.string :business_password
      t.string :business_password_digest
      t.string :email
      t.string :role

      t.timestamps
    end
  end
end
