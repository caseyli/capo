class Post < ActiveRecord::Base
  attr_accessible :body
  
  belongs_to :open_mic
  belongs_to :user
  
end
