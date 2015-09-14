class AddJacketColumnToSeries < ActiveRecord::Migration
  def up
    add_attachment :series, :jacket
  end

  def down
    remove_attachment :series, :jacket
  end
end
