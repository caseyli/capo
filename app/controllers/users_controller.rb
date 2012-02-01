class UsersController < ApplicationController
  
  before_filter :authenticate, :except => [:new, :create, :show]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => [:index, :destroy]
  
  def new
    @user = User.new
    @title = "Register"
  end
  
  def index
    @users = User.all
    @title = "Users"
  end
  
  def show
    @user = User.find(params[:id])
    @title = @user.email
  end
  
  def show_me
    if signed_in?
      @user = current_user
      respond_to do |format|
        format.json { render :json => @user.to_json }
      end
    else
      respond_to do |format|
        format.json { render :json => nil.to_json }
      end
    end
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Capo!"
      
      respond_to do |format|
        format.html { redirect_to @user }
        format.json { render :json => '{ "response" : "true" }' }
      end
      
    else
      @title = "Register"
      
      respond_to do |format|
        format.html { render 'new' }
        format.json { render :json => '{ "response" : "false", "message" : "Sorry could not create user." }' }
      end
    end
  end
  
  def edit
    @title = "Edit Profile"
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      respond_to do |format|
        format.html { redirect_to @user }
      end
    else
      @title = "Edit user"
      respond_to do |format|
        format.html { render 'edit' }
      end
    end
  end
  
  # This is separated from update because of issues with the before_filter and the respond_to conflicting
  def ajax_update
    if request.post?
      @user = User.find(params[:id])
      
      if current_user?(@user)
        if @user.update_attributes(params[:user])
          flash[:success] = "Profile updated."
          respond_to do |format|
            format.json { render :json => '{ "response" : "true"}' }
          end
        else
          @title = "Edit user"
          first_error = "Unknown Error."
          if @user.errors.any?
            first_error = @user.errors.full_messages.first
          end
          respond_to do |format|
            format.json { render :json => '{ "response" : "false", "message" : "' + first_error + '" }' }
          end
        end
      else
        respond_to do |format|
          format.json { render :json => '{ "response" : "false", "message" : "You are not authorized to edit this account." }' }
        end
      end
      
    end
  end
  
  def destroy
    destroyuser = User.find(params[:id])
    if(destroyuser == current_user)
      flash[:error] = "Cannot destroy yourself."
    else
      destroyuser.destroy
      flash[:success] = "User destroyed."
    end
    redirect_to users_path
  end
  
  private
  
    def correct_user
      @user = User.find(params[:id])
      respond_to do |format|
        format.html { redirect_to(root_path) unless current_user?(@user) }
      end
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
    

end
