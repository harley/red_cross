class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.text :content
      t.boolean :primary, default: false

      t.timestamps null: false
    end
  end
end
