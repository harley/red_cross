class AddLastRemindedAtToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :last_reminded_at, :datetime
  end
end
