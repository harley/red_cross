class ChangeDefaultForRoleInUsers < ActiveRecord::Migration
  def up
    change_column :users, :role, :string, default: ''
  end

  def down
    change_column :users, :role, :string, default: nil
  end
end
