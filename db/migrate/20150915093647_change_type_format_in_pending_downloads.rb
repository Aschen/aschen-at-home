class ChangeTypeFormatInPendingDownloads < ActiveRecord::Migration
  def change
    change_column :pending_downloads, :type, :string
  end
end
