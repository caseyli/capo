class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  include LocationsHelper
  include OpenMicsHelper

  before_filter :set_iphone_format
  before_filter :redirect_iphone_format
  
  helper_method :is_iphone_request?
    
  def set_iphone_format
    if is_iphone_request? or request.format.to_sym == :iphone
        request.format = if cookies["browser"] == "desktop" 
                         then :html 
                         else :iphone 
                         end
    end
    
    # Handle AJAX Calls
    if request.xhr?
      request.format = :json
    end
  end

  def redirect_iphone_format
    if request.format == :iphone
      redirect_to root_path
    end
  end
  
  def is_iphone_request?
      request.user_agent =~ /(iPhone)/
  end
  
end
