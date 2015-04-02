class AddCloseAtToDrives < ActiveRecord::Migration
  def change
    add_column :drives, :close_at, :datetime
  end
end
