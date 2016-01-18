class Event < ActiveRecord::Base
	belongs_to :user
	default_scope {order('created_at DESC')}
	validates :user_id, presence: true
	validates :title, presence: true, length: {minimum: 2, maximum: 64}
	validates_date :date_of_event, :between => [lambda { Date.current }, lambda { 30.days.from_now }], :between_message => "Must enter valid date"
	before_save { |event| event.time_of_event = Time.at(Time.at(0).usec + 5*60*60 + (event.time_of_event.to_i - Time.now.beginning_of_day.to_i))}
end
