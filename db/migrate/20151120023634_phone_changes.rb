class PhoneChanges < ActiveRecord::Migration
  def change
  	remove_column :users, :mobile_phone
  	add_column :users, :mobile_phone, :string
  end
end
