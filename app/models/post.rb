class Post < ActiveRecord::Base
  attr_accessible :body
  
  belongs_to :open_mic
  belongs_to :user

  default_scope order("updated_at desc")
  scope :site_news, where(:open_mic_id => nil)  
end
