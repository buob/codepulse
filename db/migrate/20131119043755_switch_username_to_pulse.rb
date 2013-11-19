class SwitchUsernameToPulse < ActiveRecord::Migration
  def up
    add_column :pulses, :username, :string
    remove_column :users, :username
  end

  def down
    add_column :users, :username, :string
    remove_column :pulses, :username
  end
end
