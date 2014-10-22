class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :fireteam_leader
      t.string :fireteam_group_type
      t.integer :level
      t.text :comments
      t.string :video_url
      t.datetime :date_time
      t.string :system
      t.boolean :open
      t.text :requests
      t.text :approvals  

      t.timestamps
    end
  end
end
