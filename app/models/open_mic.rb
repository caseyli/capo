class OpenMic < ActiveRecord::Base
  attr_accessible :name, 
                  :day_of_week, 
                  :start_time, 
                  :end_time, 
                  :street_1, 
                  :street_2, 
                  :city, 
                  :prov_state,
                  :postal_zip, 
                  :country,
                  :url,
                  :published
                  
  has_and_belongs_to_many :users
  has_and_belongs_to_many :hosts, :class_name => "User", 
                          :join_table => "hosted_open_mics_hosts",
                          :foreign_key => "hosted_open_mic_id",
                          :association_foreign_key => "host_id"
  
  has_many :posts
  
  scope :published, where(:published => true)
  
  def add_attendee(user)
    users << user
    update
  end
  
  def remove_attendee(user)
    users.delete(user)
    update
  end
  
  def remove_all_attendees
    users.delete_all
  end
  
  def add_host(user)
    hosts << user
    update
  end
  
  def remove_host(user)
    hosts.delete(user)
    update
  end
  
  def address_blank?
    (street_1.nil? || street_1.strip == "") &&
    (street_2.nil? || street_2.strip == "") &&
    (city.nil? || city.strip == "") &&
    (prov_state.nil? || prov_state.strip == "")    
  end
  
end
