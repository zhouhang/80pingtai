class User < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :name
      t.string :password
      t.string :password_digest
      t.string :business_password
      t.string :business_password_digest
      t.float  :credit
      t.float  :commission
      t.string :role
      t.references :company

      t.timestamps
    end
  end
end
