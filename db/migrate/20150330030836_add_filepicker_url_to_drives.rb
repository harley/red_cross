class AddFilepickerUrlToDrives < ActiveRecord::Migration
  def change
    add_column :drives, :filepicker_url, :string
  end
end
