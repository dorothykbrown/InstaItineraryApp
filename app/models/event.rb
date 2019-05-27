class Event < ApplicationRecord
  belongs_to :category
  # has_many :itineraries, through: :results
end
