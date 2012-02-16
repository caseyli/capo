class BrowsersController < ApplicationController

  skip_before_filter  :redirect_iphone_format
    
  def desktop
    cookies["browser"] = "desktop"
    redirect_to root_path
  end

  def mobile
    cookies["browser"] = "mobile"
    redirect_to root_path
  end
  
end