class AdditionalInformation < ActiveRecord::Migration
  def change
  	add_column :users, :password, :string
  	add_column :users, :sex, :boolean
  	add_column :users, :dob, :date
  end
end
