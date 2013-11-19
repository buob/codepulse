class AddTitlesToPulses < ActiveRecord::Migration
  def change
    add_column :pulses, :dev_title, :string, default: 'Development'
    add_column :pulses, :design_title, :string, default: 'Design'
  end
end
