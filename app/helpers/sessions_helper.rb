module SessionsHelper
  
  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    self.current_user = user
  end
  
  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end
  
  def authenticate
    deny_access unless signed_in?
  end
  
  def deny_access
    store_location
    redirect_to signin_path, :notice => "Please sign in to access this page."
  end
  
  def deny_access_for_non_admins
    if signed_in?
      redirect_to root_path, :notice => "You are not an administrator." unless current_user.admin?
    else
      deny_access
    end
  end
  
  def deny_access_for_non_hosts(open_mic)
    if signed_in?
      @open_mic = open_mic
      redirect_to root_path, :notice => "You are not the host of this Open Mic." unless @open_mic && (host?(@open_mic) || admin?)
    else
      deny_access
    end
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  def current_user?(user)
    user == current_user
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= user_from_remember_token
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def admin?
    if self.current_user.nil?
      false
    else
      self.current_user.admin?
    end
  end
  
  def host?(open_mic)
    if self.current_user.nil?
      false
    else
      open_mic.hosts.include?(self.current_user)
    end
  end
  
  private
  
    def store_location
      session[:return_to] = request.fullpath
    end
    
    def clear_return_to
      session[:return_to] = nil
    end
  
    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
    end
    
    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end
  
end
