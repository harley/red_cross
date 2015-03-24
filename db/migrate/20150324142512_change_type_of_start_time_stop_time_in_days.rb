class ChangeTypeOfStartTimeStopTimeInDays < ActiveRecord::Migration
  def up
    change_column :days, :start_time, :string
    change_column :days, :stop_time, :string
  end

  def down
    change_column :days, :start_time, :datetime
    change_column :days, :stop_time, :datetime
  end
end
