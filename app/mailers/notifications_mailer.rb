class NotificationsMailer < ActionMailer::Base
  default :from => "from@example.com"
  
  def open_mic_submitted(open_mic)
    @open_mic = open_mic
    mail(:to => "casey.li@gmail.com",
         :from => "capoapp@gmail.com",
         :subject => "Open Mic Submitted for #{open_mic.name}")
  end
  
  def user_registered(user)
    @user = user
    mail(:to => "casey.li@gmail.com",
         :from => "capoapp@gmail.com",
         :subject => "New User Registered for #{user.email}")
  end
end
