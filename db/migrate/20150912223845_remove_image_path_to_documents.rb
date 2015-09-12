class RemoveImagePathToDocuments < ActiveRecord::Migration
  def change
    remove_column :documents, :image
    remove_column :documents, :path
    remove_column :folders, :image
  end
end
