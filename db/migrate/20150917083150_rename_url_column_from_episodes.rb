class RenameUrlColumnFromEpisodes < ActiveRecord::Migration
  def change
    rename_column :episodes, :url, :original_file
  end
end
