class OpenMicObserver < ActiveRecord::Observer
  
  def after_create(open_mic)
    NotificationsMailer.open_mic_submitted(open_mic).deliver
  end
end
