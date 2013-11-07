class CreateSocialProfiles < ActiveRecord::Migration
  def change
    create_table :social_profiles do |t|
      t.string :url
      t.string :name
      t.string :color
      t.integer :display_order

      t.timestamps
    end
  end
end
