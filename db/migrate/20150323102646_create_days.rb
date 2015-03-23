class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.references :drive, index: true, foreign_key: true
      t.date :date
      t.datetime :start_time
      t.datetime :stop_time

      t.timestamps null: false
    end
  end
end
