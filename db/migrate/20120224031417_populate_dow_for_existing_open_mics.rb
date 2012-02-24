class PopulateDowForExistingOpenMics < ActiveRecord::Migration
  def self.up
    # update open_mics
    execute <<-SQL
      update open_mics set dow = 0 where day_of_week='Sunday';
      update open_mics set dow = 1 where day_of_week='Monday';
      update open_mics set dow = 2 where day_of_week='Tuesday';
      update open_mics set dow = 3 where day_of_week='Wednesday';
      update open_mics set dow = 4 where day_of_week='Thursday';
      update open_mics set dow = 5 where day_of_week='Friday';
      update open_mics set dow = 6 where day_of_week='Saturday';
    SQL
  end

  def self.down
    # update open_mics
    execute <<-SQL
      update open_mics set dow = null;
    SQL
  end
end
