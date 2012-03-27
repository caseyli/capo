class OpenMicsController < ApplicationController
  
  respond_to :json, :html
  
  before_filter :deny_access_for_non_admins, :only => [:edit, :destroy, :add_host, :remove_host]
  before_filter :authenticate              , :only => [:attend, :unattend]
  before_filter :split_city_and_prov_state , :only => [:index]
  
  def new
    @open_mic = OpenMic.new
    @title = "Create New Open Mic"
  end
  
  def create
    @open_mic = OpenMic.new(params[:open_mic])
    if @open_mic.save
      flash[:success] = "Thank you for submitting your Open Mic. Once it is approved it will show up in list!"
      redirect_to @open_mic
    else
      @title = "Create New Open Mic"
      render 'new'
    end
  end
  
  def show
    @open_mic = OpenMic.find(params[:id])
    @gmaps_address = gmaps_address(@open_mic)
    @posts = @open_mic.posts.order(:updated_at).limit(5)
    
    @post = Post.new if can_manage_posts_for(@open_mic)
    
    respond_to do |format|
      format.html
      format.json { render :json => @open_mic.as_json(:include => :hosts) }
    end
  end
  
  def index
    @selectable_cities_with_prov_state = cities_with_prov_state
    @open_mics = OpenMic.scoped
    @open_mics = @open_mics.published unless admin?
    @open_mics = @open_mics.where(:city => @city, :prov_state => @prov_state) if @selected_city_prov_state.present?
    
    respond_to do |format|
      format.html
      format.json { render :json => @open_mics }
    end
  end
  
  def edit
    @open_mic = OpenMic.find(params[:id])
  end
  
  def update
    @open_mic = OpenMic.find(params[:id])
    if @open_mic.update_attributes(params[:open_mic])
      flash[:success] = "Open Mic Updated."
      redirect_to @open_mic
    else
      @title = "Edit Open Mic"
      render 'edit'
    end
  end
  
  def destroy
    OpenMic.find(params[:id]).destroy
    redirect_to open_mics_path
  end
  
    
  def add_host
    user = User.find_by_id(params[:host_to_add][:id])
    open_mic = OpenMic.find(params[:id])
    open_mic.add_host(user)
    redirect_to open_mic
  end
  
  def remove_host
    user = User.find_by_id(params[:host_to_remove])
    open_mic = OpenMic.find(params[:id])
    open_mic.remove_host(user)
    redirect_to open_mic
  end
  
  def attend

    @open_mic = OpenMic.find(params[:id])
    
    @open_mic.add_attendee(current_user)

    if @open_mic.errors.empty?
      response = {:response => true, :attendee_count => @open_mic.users.size}
    else
      error_message = "You are already attending this open mic."
      flash[:error] = error_message
      response = {:response => false, :message => error_message}
    end

    respond_with(response) do |format|
      format.html { redirect_to @open_mic }
    end
  end
  
  def unattend
    @open_mic = OpenMic.find(params[:id])
    @open_mic.remove_attendee(current_user)
    
    respond_to do |format|
      format.html { redirect_to @open_mic}
      format.json { render :json => { :response => true, :attendee_count => @open_mic.users.size }.to_json }
    end
  end
  
  def attending_info
    @open_mic = OpenMic.find(params[:id])
    count = @open_mic.users.size
    attending = @open_mic.users.include?(current_user) ? true : false
    respond_to do |format|
      format.json { render :json =>  { :attending => attending, :attendee_count => count }.to_json }
    end
  end
  
  def attendee_list
    @open_mic = OpenMic.find(params[:id])
    respond_to do |format|
      format.json { render :json => @open_mic.users.to_json }
    end
  end
  
  def selectable_cities_with_prov_state
    respond_to do |format|
      format.json { render :json => cities_with_prov_state.to_json }
    end
  end
  

  private
  
    def cities_with_prov_state
      OpenMic.unscoped.select("DISTINCT CITY, PROV_STATE").collect { |x| "#{x.city}, #{x.prov_state}" }
    end
    
    def split_city_and_prov_state
      @selected_city_prov_state = params[:filter_city_prov_state]
      @city = params[:filter_city_prov_state].split(',').first unless @selected_city_prov_state.blank?
      @prov_state = params[:filter_city_prov_state].split(',').last.strip unless @selected_city_prov_state.blank?
    end
  
    def gmaps_address(open_mic)
      if open_mic.street_1.nil? || open_mic.street_1.strip == '' ||
        open_mic.city.nil? || open_mic.city.strip == ''
        nil
      else
        ret = open_mic.street_1 + " " + open_mic.city
        if !open_mic.prov_state.nil? && open_mic.prov_state.strip != ''
          ret += ", " + open_mic.prov_state
        end
        ret
      end
        
    end

end
