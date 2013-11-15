class AddUsernamesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :github_user, :string
  end
end
