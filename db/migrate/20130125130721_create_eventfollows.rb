class CreateEventfollows < ActiveRecord::Migration
  def change
    create_table :eventfollows do |t|
      t.integer :event_id
      t.integer :follower_id

      t.timestamps
    end
      add_index :eventfollows, :event_id
      add_index :eventfollows, :follower_id
      add_index :eventfollows, [:event_id, :follower_id], unique: true
  end
end
