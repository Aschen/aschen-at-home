class CreateSeries < ActiveRecord::Migration
  def change
    create_table :series do |t|
      t.string :name
      t.string :key_words
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
