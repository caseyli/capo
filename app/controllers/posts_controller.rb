class PostsController < ApplicationController
  
  before_filter :load_open_mic
  before_filter :except => [:index] do |controller|
    deny_access_for_non_hosts(@open_mic)
  end
  
  def create
    @post  = @open_mic.posts.build(params[:post])
    @post.user = current_user    
        
    if @post.save
      flash[:success] = "Posted!"
    end

    redirect_to @open_mic
  end

  def index
  end
  
  def destroy
    @post = Post.find(params[:id])    
    @post.destroy
    redirect_to open_mic_posts_url(@open_mic)
  end
  
  private
    def load_open_mic
      @open_mic = OpenMic.find(params[:open_mic_id])
    end
    
end
