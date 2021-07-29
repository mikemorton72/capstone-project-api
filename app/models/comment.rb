class Comment < ApplicationRecord
  validates :text, length: { minimum: 2}
  belongs_to :user
  belongs_to :run
end