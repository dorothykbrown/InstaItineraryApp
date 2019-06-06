class Result < ApplicationRecord
  belongs_to :itinerary
  belongs_to :event

  validates :itinerary_id, uniqueness: { scope: :event_id }

  # validates_uniqueness_of :address, {scope: :event_id}
end
