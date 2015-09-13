class CreateWishes < ActiveRecord::Migration
  def change
    create_table :wishes do |t|
      t.string :name
      t.integer :price
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
