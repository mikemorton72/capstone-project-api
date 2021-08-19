class Run < ApplicationRecord
  validates :title, length: {minimum: 2}
  validates :distance, numericality: {greater_than: 0}
  validates :elapsed_time, numericality: {greater_than: 0}
  validates :start_latitude, presence: true
  validates :start_longitude, presence: true
  validates :location_name, presence: true
  belongs_to :user
  has_many :comments

  def distance_miles
    return self.distance * 0.000621371
  end
  
  def pace
    pace = self.elapsed_time / 60 / self.distance_miles
    minutes = (pace - pace % 1).to_i
    seconds = (60 * (pace % 1)).to_i
    if seconds.to_s.length < 2
      seconds = "0#{seconds}"
    end
    "#{minutes}:#{seconds}"
  end
end
