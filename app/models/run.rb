class Run < ApplicationRecord
  validates :title, length: {minimum: 2}
  validates :distance, numericality: {greater_than: 0}
  validates :elapsed_time, numericality: {greater_than: 0}
  belongs_to :user
  has_many :comments

  def time_minutes
    return self.elapsed_time.to_f / 60
  end
end
