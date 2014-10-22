class CreateEventComments < ActiveRecord::Migration
  def change
    create_table :event_comments do |t|
    	t.integer :event_id 
    	t.string :user_id 
    	t.text :comment 
    	
    	t.timestamps 
    end
  end
end
