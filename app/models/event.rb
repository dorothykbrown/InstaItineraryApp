class Event < ApplicationRecord
  belongs_to :category
  has_many :preferences, through: :results
end
