class AddLinkToWishes < ActiveRecord::Migration
  def change
    add_column :wishes, :link, :string
  end
end
