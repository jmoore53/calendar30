class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string 	:firstN
    	t.string 	:lastN
    	t.string 	:email

    	t.integer :mobile_phone
      t.timestamps null: false
    end
  end
end
