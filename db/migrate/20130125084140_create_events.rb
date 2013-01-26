class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :details
      t.datetime :start_time
      t.datetime :end_time
      t.string :address
      t.float :latitude
      t.float :longitude
      t.boolean :gmaps
      t.integer :user_id

      t.timestamps
    end
  end
end
