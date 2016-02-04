class ChangeTimeAddDate < ActiveRecord::Migration
  def change
  	remove_column :events, :time 
  	add_column :events, :time_of_event, :time
  	add_column :events, :date_of_event, :date 
  end
end
