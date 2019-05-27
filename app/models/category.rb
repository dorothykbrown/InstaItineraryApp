class Category < ApplicationRecord
  has_many :events
  has_many :users, through: :user_category
end
