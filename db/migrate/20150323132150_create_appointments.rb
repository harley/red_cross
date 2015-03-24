class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.references :user, index: true, foreign_key: true
      t.references :day, index: true, foreign_key: true
      t.references :drive, index: true, foreign_key: true
      t.boolean :double_red, default: false
      t.datetime :slot_time

      t.timestamps null: false
    end
  end
end
