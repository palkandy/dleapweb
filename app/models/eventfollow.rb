class Eventfollow < ActiveRecord::Base
  attr_accessible :event_id, :follower_id

  belongs_to :follower, class_name: "User"
  belongs_to :event, class_name: "Event"

  validates :follower_id, presence: true
  validates :event_id, presence: true
end
