class AddDownloadedToPendingDownloads < ActiveRecord::Migration
  def change
    add_column :pending_downloads, :completed, :boolean
  end
end
