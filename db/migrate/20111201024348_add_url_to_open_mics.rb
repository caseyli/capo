class AddUrlToOpenMics < ActiveRecord::Migration
  def self.up
    add_column :open_mics, :url, :string
  end

  def self.down
    remove_column :open_mics, :url
  end
end
