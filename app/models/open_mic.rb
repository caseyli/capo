class OpenMic < ActiveRecord::Base
  attr_accessible :name, 
                  :start_time, 
                  :end_time, 
                  :street_1, 
                  :street_2, 
                  :city, 
                  :prov_state,
                  :postal_zip, 
                  :country,
                  :url,
                  :published,
                  :dow
                  
  has_and_belongs_to_many :users
  has_and_belongs_to_many :hosts, :class_name => "User", 
                          :join_table => "hosted_open_mics_hosts",
                          :foreign_key => "hosted_open_mic_id",
                          :association_foreign_key => "host_id"
  
  has_many :posts
  
  default_scope order("dow")
  scope :published, where(:published => true).order("dow")
  
  validates :name, :presence => true
  validates :dow, :presence => true
  
  def add_attendee(user)
    if !users.include?(user)
      users << user
    else
      errors.add(:users, " already contains the user.")
    end
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
    street_1.blank? &&
    street_2.blank? &&
    city.blank? &&
    prov_state.blank?    
  end
  
end
