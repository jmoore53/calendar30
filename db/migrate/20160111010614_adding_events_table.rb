class AddingEventsTable < ActiveRecord::Migration
  def change
  	create_table :events do |t|
  		t.string :title
  		t.belongs_to :user, index:true
  		t.datetime :time
  		t.timestamps null: false
  	end
  end
end
