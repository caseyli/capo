class AddPublishedToOpenMics < ActiveRecord::Migration
  def self.up
    add_column :open_mics, :published, :boolean
  end

  def self.down
    remove_column :open_mics, :published
  end
end
