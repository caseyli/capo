class UserObserver < ActiveRecord::Observer
  
  def after_create(user)
    NotificationsMailer.user_registered(user).deliver
  end
  
end
