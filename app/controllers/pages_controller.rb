class PagesController < ApplicationController
  def about
  end

  def feedback
    @success = false
    if !params[:email_address].blank? && !params[:message].blank?
      FeedbackMailer.feedback_email("Capo Feedback from " + params[:email_address],
                                  params[:email_address],
                                  params[:message]).deliver
      @success = true
    end  
  end

end
