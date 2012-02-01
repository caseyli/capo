class CreateOpenMicsUsersJoinTable < ActiveRecord::Migration
  def self.up
    create_table :open_mics_users, :id => false do |t|
      t.integer :open_mic_id
      t.integer :user_id
    end
  end

  def self.down
    drop_table :open_mics_users
  end
end
