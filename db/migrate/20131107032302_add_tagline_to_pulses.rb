class AddTaglineToPulses < ActiveRecord::Migration
  def change
    add_column :pulses, :tagline, :string
  end
end
