class MainController < ApplicationController
  
  skip_before_filter  :redirect_iphone_format, :only => [:home]
  
  def home
    
  end

end
