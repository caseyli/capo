class AddDowToOpenMics < ActiveRecord::Migration
  def self.up
    add_column :open_mics, :dow, :integer
  end

  def self.down
    remove_column :open_mics, :dow
  end
end
