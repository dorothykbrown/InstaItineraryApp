# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


puts 'Creating Seeds...'
# User
users = [
  {
    email: 'dorothy@whimaway.com',
    password: '123456',
    name: 'Dorothy'
  },

  {
    email: 'jv@whimaway.com',
    password: '654321',
    name: 'John'
  },

  {
    email: 'simone@whimaway.com',
    password: 'denver',
    name: 'Simone'
  },

  {
    email: 'patricia@whimaway.com',
    password: 'lisboa',
    name: 'Patricia'
  }
]

users.each do |user|
  User.create!(user)
end

# Itinerary
itineraries = [
  {
    location: 'Lisbon, Portugal',
    search_radius: '5 km',
    available_time: 3, # hours
    name: 'Lisbon Itinerary',
    user: User.all.sample
  },

  {
    location: 'Porto, Portugal',
    search_radius: '2 km',
    available_time: 3, # hours
    name: 'Porto Itinerary',
    user: User.all.sample
  }
]

itineraries.each do |itin|
  Itinerary.create!(itin)
end

# Category

categories = [
  {
    name: 'Music'
  },

  {
    name: 'Art'
  },

  {
    name: 'History'
  },

  {
    name: 'Food'
  }
]

categories.each do |category|
  Category.create(category)
end

# Event
events = [
  {
    name: 'Dancing in the Park',
    duration: 3,
    description: 'Salsa social dancing with live music',
    address: 'Avenida da Liberdade, Quiosques Liberdade - Posto 4, 1250-145 Lisboa',
    rating: 4,
    category: Category.find_by(name: "Music")
  },

  {
    name: 'Dine in Lisbon',
    duration: 2,
    description: 'Experience authentic Portugues cuisine',
    address: 'Rua das Portas de Santo Antão 23, 1150-264 Lisboa',
    rating: 5,
    category: Category.find_by(name: "Food")
  }
]

events.each do |event|
  Event.create(event)
end

puts 'Finished!'
