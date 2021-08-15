class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  has_many :follower_follows, foreign_key: :followee_id, class_name: "Follow"
  has_many :followers, through: :follower_follows
  has_many :followee_follows, foreign_key: :follower_id, class_name: "Follow"
  has_many :followees, through: :followee_follows
  has_many :runs
  has_many :comments

  def total_miles
    self.runs.reduce(0) {|sum, run| sum += run.distance_miles}
  end
  
  def has_strava
    if self.strava_access_token
      true
    else
      false
    end
  end
end
