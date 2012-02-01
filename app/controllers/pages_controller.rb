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
      
      respond_to do |format|
        format.html
        format.json { render :json => '{ "response" : "true" }' }
      end
    else
      respond_to do |format|
        format.html
        format.json { render :json => '{ "response" : "false" }' }
      end
    end  
  end

end
