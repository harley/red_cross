class AddIndexToAppointments < ActiveRecord::Migration
  def change
    add_index :appointments, [:day_id, :slot_time]
  end
end
