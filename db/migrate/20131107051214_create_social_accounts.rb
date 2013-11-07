class CreateSocialAccounts < ActiveRecord::Migration
  def change
    create_table :social_accounts do |t|
      t.string :handle
      t.references :social_profile, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
