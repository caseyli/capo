class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :first_name,:presence     => true
  
  validates :last_name, :presence     => true
  
  validates :email,     :presence     => true,
                        :format       => { :with => email_regex },
                        :uniqueness   => true
                    
  validates :password,  :presence     => true,
                        :confirmation => true,
                        :length       => { :within => 6..40 }                       
                        
                        
  before_save :encrypt_password
  
  has_and_belongs_to_many :open_mics
  has_and_belongs_to_many :hosted_open_mics, 
                          :class_name => "OpenMic", :join_table => "hosted_open_mics_hosts",
                          :foreign_key => "host_id",
                          :association_foreign_key => "hosted_open_mic_id"
  
  has_many :posts
  
  default_scope order("first_name")
  
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
    user = User.find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end
  
  def full_name
    first_name + " " + last_name
  end
  
  private
  
    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end
    
    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end
