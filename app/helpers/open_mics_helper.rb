module OpenMicsHelper

  def can_manage_posts_for(open_mic)
    host?(open_mic) || admin?
  end

end
