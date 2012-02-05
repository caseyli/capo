class PostsController < ApplicationController
  
  def create
    @post  = current_user.posts.build(params[:post])
    @post.open_mic = OpenMic.find_by_id(params[:post][:open_mic_id])
    
    deny_access_for_non_hosts(@post.open_mic)
    
    if @post.save
      flash[:success] = "Posted!"
    end

    redirect_to @post.open_mic
  end

  #
  # Called by /open_mics/:id/posts
  #
  def index
    @open_mic = OpenMic.find_by_id(params[:open_mic_id])
  end
  
  def destroy
    @post = Post.find(params[:id])
    @open_mic = @post.open_mic
    
    deny_access_for_non_hosts(@open_mic)
    
    @post.destroy
    redirect_to open_mic_posts_url(@open_mic)
  end

end
