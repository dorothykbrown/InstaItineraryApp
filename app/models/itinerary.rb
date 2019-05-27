class Itinerary < ApplicationRecord
  belongs_to :user
  # has_many :events, through: :results
end
