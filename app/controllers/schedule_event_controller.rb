class ScheduleEventController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]

	def create
		@event = current_user.events.build(event_params)
		if @event.save
			flash[:notice] = "Your event was created successfully."
			redirect_to root_url
		else
			flash[:error] = "There was a problem creating your event."
			redirect_to root_url
		end
	end

	def destroy
	end

	private
		def event_params
			params.require(:event).permit(:title, :date_of_event, :time_of_event)
		end
end
