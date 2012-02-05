class PostsController < ApplicationController
  def new
    @post = Post.new
    @title = "Create New Post"
  end

  def create
    @post  = current_user.posts.build(params[:post])
    @post.open_mic = OpenMic.find_by_id(params[:post][:open_mic_id])
    if @post.save
      flash[:success] = "Posted!"
      redirect_to @post.open_mic
    else
      render 'pages/home'
    end
  end

  def destroy
  end

end
