class CreateHostedOpenMicsHostsJoinTable < ActiveRecord::Migration
  def self.up
    create_table :hosted_open_mics_hosts, :id => false do |t|
      t.integer :hosted_open_mic_id
      t.integer :host_id
    end
  end

  def self.down
    drop_table :hosted_open_mics_hosts
  end
end
