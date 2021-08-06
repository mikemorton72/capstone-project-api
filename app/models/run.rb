class Run < ApplicationRecord
  validates :title, length: {minimum: 2}
  validates :distance, numericality: {greater_than: 0}
  validates :elapsed_time, numericality: {greater_than: 0}
  belongs_to :user
  has_many :comments

  def distance_miles
    return self.distance * 0.000621371
  end
end
