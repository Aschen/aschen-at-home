class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.integer :number
      t.integer :episodes_count
      t.boolean :auto_download
      t.integer :series_id

      t.timestamps null: false
    end
  end
end
