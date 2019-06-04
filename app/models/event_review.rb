class EventReview < ApplicationRecord
  belongs_to :event
  has_one :review
end
