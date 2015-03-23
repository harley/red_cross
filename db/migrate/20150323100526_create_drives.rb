class CreateDrives < ActiveRecord::Migration
  def change
    create_table :drives do |t|
      t.string :name
      t.string :location
      t.string :contact_email
      t.integer :max_per_slot, default: 8
      t.integer :time_per_slot, default: 15

      t.timestamps null: false
    end
  end
end
