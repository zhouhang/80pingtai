class CreateWebapis < ActiveRecord::Migration
  def change
    create_table :webapis do |t|
      t.string :name
      t.string :pinyin

      t.timestamps
    end
  end
end
