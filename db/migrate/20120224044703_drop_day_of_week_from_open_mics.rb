class DropDayOfWeekFromOpenMics < ActiveRecord::Migration
  def self.up
    remove_column :open_mics, :day_of_week
  end

  def self.down
    add_column :open_mics, :day_of_week, :string
  end
end
