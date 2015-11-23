class CreateLunchTimes < ActiveRecord::Migration
  def change
    create_table :lunch_times do |t|
    	t.datetime :lunch_dat

      t.timestamps null: false
    end
  end
end
