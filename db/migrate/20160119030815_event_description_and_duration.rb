class EventDescriptionAndDuration < ActiveRecord::Migration
  def change
  	add_column :events, :duration, :integer
  	add_column :events, :description, :string
  end
end
