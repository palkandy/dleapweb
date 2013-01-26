# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :address
  has_secure_password
  has_many :microposts, dependent: :destroy
  has_many :events, dependent: :destroy

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower


  has_many :eventfollows, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_events, through: :eventfollows, source: :event
  
  
  #These two lines should go in the events table ...
  
  #has_many :reverse_eventfollows, foreign_key: "followed_id",
#	                                     class_name:  "Relationship",
					           #                            dependent:   :destroy
 #   has_many :followers, through: :reverse_relationships, source: :follower




  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  acts_as_gmappable

  def gmaps4rails_address
	  #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
	   "#{self.address}"
	  #
  end

  def feed
    @posts = Micropost.from_users_followed_by(self)
# TBD: Take care of events here ....    @events =
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end


   def eventfollowing?(event)
	   eventfollows.find_by_follower_id(self.id)
   end

    def eventfollow!(event)
	eventfollows.create!( event.id)
    end

    def eventunfollow!(event)
      eventfollows.find_by_event_id(event.id).destroy
    end
  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
