class CreateOpenMics < ActiveRecord::Migration
  def self.up
    create_table :open_mics do |t|
      t.string :name
      t.string :day_of_week

      t.timestamps
    end
  end

  def self.down
    drop_table :open_mics
  end
end
