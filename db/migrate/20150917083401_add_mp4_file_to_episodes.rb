class AddMp4FileToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :mp4_file, :string
  end
end
