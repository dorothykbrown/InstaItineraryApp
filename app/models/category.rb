class Category < ApplicationRecord
  has_many :events
  has_many :user_categories
  has_many :users, through: :user_categories
end
