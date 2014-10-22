class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token 
  
  
  # GET /events
  # GET /events.json
  def index

	puts params.inspect
	puts "####"  
	if params[:event].present?
		@events = Event.where(system: params[:event][:system], fireteam_group_type: params[:event][:fireteam_group_type], open: true).paginate(page: params[:page], per_page: 10)
	else 
		@events = Event.where(open: true).paginate(page: params[:page], per_page: 10)
	end 
	
    if current_user != nil 
	    user = current_user
	    list = user.events_requested 
	    @my_events = []
	    list.each do |event|    	
	    	@my_events << Event.where(id: event)
	    end 
	end 
  end

  # GET /events/1
  # GET /events/1.json
  def show
  	event_requests = Event.where(id: params[:id])
  	@leader = User.where(id: event_requests.first.fireteam_leader)
  	@fireteam_array = []
  	if event_requests.first.fireteam_leader == current_user.id 
	  	@request_array = []
	  	@approval_array = []
	  	
	  	event_requests.first.requests.each do |x|
	  		@request_array << User.where(id: x)
	  	end 
	  	
	  	
	  	
	  	event_requests.first.approvals.each do |x|
	  		@approval_array << x
	  	end 
	    	
	end 
	
	event_requests.first.approvals.each do |x|
  		puts x.inspect 
  		puts "@@@@@@"
  		@fireteam_array << User.where(id: x)
  	end 
  	
  	
  	@announcements = EventComment.where(event_id: event_requests.first.id)
  end

  # GET /events/new
  def new

  	if current_user.psn == nil && current_user.xbl == nil 
  		redirect_to edit_user_registration_url, notice: 'You need a PSN/XBL gamertag to post a new event.'
  	else 
    @event = Event.new
    end 
  end

  # GET /events/1/edit
  def edit
  	puts params.inspect
  	puts "######"
  	event = Event.where(id: params[:id])
  	if event.first.fireteam_leader != current_user.id 
  		redirect_to root_url, notice: 'Not manager of this event, unable to edit.'
  	end 
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    
    @event.fireteam_leader = current_user.id
	@event.requests = [ ]
	@event.approvals = [ ]
	
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  
  
  def events_manage
  	@events = Event.where(fireteam_leader: current_user.id)
  	
  	if !@events.present?
  		redirect_to root_url, notice: 'You have no events to manage.' 
  	end 
  
  end 
  
  
  def join_event 
  	event = Event.where(id: params[:id])
  	@gamertag = 0
  	
  	if current_user.psn != nil 
  		@gamertag += 1
  	end 
  	
  	if current_user.xbl != nil 
  		@gamertag += 1
  	end 
  	
  	if event != nil 
  		if !current_user.guardian_type?
	   		redirect_to edit_user_registration_url, notice: 'Before you request to join an event please list your PSN/XBL gamertag Guardian Type and Level!!' 
	   	elsif @gamertag < 1
	   		redirect_to edit_user_registration_url, notice: 'You do not have a PSN/XBL gamertag listed!!' 
	   	else 
	   		event.first.requests << current_user.id 
	  		event.first.save
	  		
	  		current_user.events_requested << event.first.id
	  		current_user.save
	  		
	  		redirect_to root_url, notice: 'Your request to join this event has been sent, awaiting approval!!' 
	  	end 
  	end 
  end 
  
  
  def live_event 
  
  end 
  
  
  def announcement_post
  	EventComment.create(event_id: params[:id], user_id: current_user.id, comment: params[:announcement])	
  	redirect_to(:back)
  end 
  
  def approve
  
  	event = Event.where(id: params[:id])
  	user = User.where(id: params[:user_id])
  	
  	event.first.approvals << user.first.id 
  	event.first.save
  	redirect_to(:back)

  end 
  
  def close_event
  	update_event = Event.where(id: params[:id])
  	update_event.first.open = false 
  	update_event.first.save
  	redirect_to(:back)
  end 
  
  def open_event
  	update_event = Event.where(id: params[:id])
  	update_event.first.open = true 
  	update_event.first.save
  	redirect_to(:back)
  end 
    
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:fireteam_leader, :fireteam_group_type, :level, :comments, :video_url, :date_time, :system)
    end
end
