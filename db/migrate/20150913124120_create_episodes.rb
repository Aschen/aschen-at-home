class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.integer :number
      t.boolean :watched
      t.boolean :downloaded
      t.integer :season_id

      t.timestamps null: false
    end
  end
end
