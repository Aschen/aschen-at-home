class RenameColumnsTypeInPendingDownload < ActiveRecord::Migration
  def change
    rename_column :pending_downloads, :type, :download_type
  end
end
