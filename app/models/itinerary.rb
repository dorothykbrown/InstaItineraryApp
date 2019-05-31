class Itinerary < ApplicationRecord
  belongs_to :user
  has_many :results
  has_many :events, through: :results

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  # validates :name, presence: true
  validates :location, presence: true
  validates :search_radius, presence: true
  validates :available_time, presence: true
  # validates :transit_mode, presence: true
end
