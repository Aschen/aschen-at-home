class CreatePendingDownloads < ActiveRecord::Migration
  def change
    create_table :pending_downloads do |t|
      t.string :name
      t.integer :type
      t.integer :season_id
      t.integer :episode_id

      t.timestamps null: false
    end
    add_index :pending_downloads, :name
  end
end
