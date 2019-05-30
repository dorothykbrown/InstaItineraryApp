class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :itineraries
  has_many :user_categories
  has_many :categories, through: :user_categories

  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true
end
