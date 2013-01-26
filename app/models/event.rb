class Event < ActiveRecord::Base
  attr_accessible :details, :end_time, :start_time,  :address, :latitude, :longitude, :gmaps
  belongs_to :user

   validates :details, presence: true, length: { maximum: 140 }
   validates :user_id, presence: true
   default_scope order: 'events.created_at DESC'

   has_many :microposts
   has_many :eventfollows, foreign_key: "event_id", dependent: :destroy
   has_many :followers, through: :eventfollows, source: :event

     acts_as_gmappable

   def gmaps4rails_address
      #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code,
	       # see wiki
           "#{self.address}"
   end
   
   def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
          user_id: user.id)
  end

end
