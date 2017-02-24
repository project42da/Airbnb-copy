class Review < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validates :comment, presence: true, length: {maximum: 100}
end
