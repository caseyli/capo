class AddAddressAndTimesToOpenMics < ActiveRecord::Migration
  def self.up
    add_column :open_mics, :start_time, :time
    add_column :open_mics, :end_time, :time
    add_column :open_mics, :street_1, :string
    add_column :open_mics, :street_2, :string
    add_column :open_mics, :city, :string
    add_column :open_mics, :prov_state, :string
    add_column :open_mics, :postal_zip, :string
    add_column :open_mics, :country, :string
  end

  def self.down
    remove_column :open_mics, :country
    remove_column :open_mics, :postal_zip
    remove_column :open_mics, :prov_state
    remove_column :open_mics, :city
    remove_column :open_mics, :street_2
    remove_column :open_mics, :street_1
    remove_column :open_mics, :end_time
    remove_column :open_mics, :start_time
  end
end
