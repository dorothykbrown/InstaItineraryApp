class Event < ApplicationRecord
  mount_uploader :photo, PhotoUploader

  belongs_to :category
  has_many :results
  has_many :itineraries, through: :results
  has_many :reviews

  # validates :address, uniqueness: true

  # geocoded_by :address
  # after_validation :geocode, if: :will_save_change_to_address?
  validates :latitude, presence: true
  validates :longitude, presence: true
end
