class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :netid, index: true
      t.string :email, index: true
      t.string :fname
      t.string :lname
      t.string :email
      t.string :year
      t.string :college
      t.text :session

      t.timestamps null: false
    end
  end
end
