class BrowsersController < ApplicationController
    
  def desktop
    cookies["browser"] = "desktop"
    redirect_to root_path
  end

  def mobile
    cookies["browser"] = "mobile"
    redirect_to root_path
  end
  
end