class MoveSocialAssociationToPulse < ActiveRecord::Migration
  def change
    add_column :social_accounts, :pulse_id, :integer, index: true
    remove_column :social_accounts, :user_id, index: true
  end

  def down
    add_column :social_accounts, :user_id, :integer, index: true
    remove_column :social_accounts, :pulse_id, index: true
  end
end
