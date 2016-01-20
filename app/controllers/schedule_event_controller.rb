class ScheduleEventController < ApplicationController
	before_action :logged_in_user, only: [:create, :edit, :update, :destroy]

	def create
		@event = current_user.events.create(event_params)
		if @event.save
			flash[:notice] = "Your event was created successfully."
			redirect_to root_url
		else
			flash[:error] = "There was a problem creating your event. Please check everything is correct."
			redirect_to root_url
		end
	end

	def edit
		@event = Event.find(params[:id])
	end

	def show		
    	@event = Event.find(params[:id]) if logged_in?
    	@user = User.find(@event.user_id) if logged_in?
    	#@user = User.find(params[:user_id])
  	end

	def update
		@event = Event.find(params[:id])

		if @event.update(event_params)
			flash[:notice] = "Your event has been updated successfully"
			redirect_to url_for(:controller => :schedule_event, :action => :edit)
		else
			flash[:error] = "There was a problem updating your event."
			render 'edit'
		end
	end

	def delete
    	@event = Event.find(params[:id])
    	@event.destroy
	end

	def destroy
	    event = Event.find(params[:id])
	    event.destroy
	    flash[:notice] = "Event was deleted"
	    redirect_to(:controller =>'user', :action => 'index')
	end
	

	private
		def event_params
			params.require(:event).permit(:title, :description, :date_of_event, :time_of_event)
		end
end
