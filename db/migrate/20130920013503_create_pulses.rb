class CreatePulses < ActiveRecord::Migration
  def change
    create_table :pulses do |t|
      t.references :user, index: true
      t.string :url

      t.timestamps
    end
  end
end
