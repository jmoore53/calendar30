class ScheduleEventController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]

	def index
	end

	def create
		@event = current_user.events.build(event_params)
		if @event.save
			redirect_to root_url
		else
			render 'static_pages/home'
		end
	end

	def destroy
	end

	private
		def event_params
			params.require(:event).permit(:user_id, :title, :date_of_event, :time_of_event)
		end
end
