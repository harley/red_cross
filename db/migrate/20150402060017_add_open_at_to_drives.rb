class AddOpenAtToDrives < ActiveRecord::Migration
  def change
    add_column :drives, :open_at, :datetime
  end
end
