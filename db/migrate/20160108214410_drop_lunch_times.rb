class DropLunchTimes < ActiveRecord::Migration
  def change
	drop_table :lunch_times
  end
end
