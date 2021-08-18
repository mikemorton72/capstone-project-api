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

  def average_pace # units are min/mile
    if self.runs.length > 0
      paces = self.runs.map {|run| run.elapsed_time / 60 / run.distance_miles}
      sum = paces.reduce(0) {|sum, pace| sum += pace}
      avg = sum / paces.length
      minutes = (avg - avg % 1).to_i
      seconds = (60 * (avg % 1)).to_i
      if seconds.to_s.length < 2
        seconds = "0#{seconds}"
      end
      "#{minutes}:#{seconds}"
    end
  end
  
  def has_strava
    if self.strava_access_token
      true
    else
      false
    end
  end
end
