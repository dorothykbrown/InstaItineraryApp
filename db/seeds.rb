# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Event.destroy_all
Category.destroy_all
Itinerary.destroy_all
User.destroy_all


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
    user: User.all.sample,
    transit_mode: 'walk'
  },

  {
    location: 'Porto, Portugal',
    search_radius: '2 km',
    available_time: 3, # hours
    name: 'Porto Itinerary',
    user: User.all.sample,
    transit_mode: 'walk'
  }
]

itineraries.each do |itin|
  Itinerary.create!(itin)
end

# Category

categories = [
  {
    name: 'Music',
    image_url: 'https://images.unsplash.com/photo-1429962714451-bb934ecdc4ec?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60',
  },

  {
    name: 'Art and Architecture',
    image_url: 'https://images.unsplash.com/photo-1499781350541-7783f6c6a0c8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60',
  },

  {
    name: 'Nature',
    image_url: 'https://images.unsplash.com/photo-1453785675141-67637e2d4b5c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60'
  },

  {
    name: 'Nightlife',
    image_url: 'https://images.unsplash.com/photo-1519214605650-76a613ee3245?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60'
  },

  {
    name: 'Historical Sites',
    image_url: 'https://images.unsplash.com/photo-1467383670897-225b16e3cc9a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60'
  },

  {
    name: 'Points of Interest',
    image_url: 'https://images.unsplash.com/photo-1542567455-cd733f23fbb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60'
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
    address: 'Avenida da Liberdade, Lisboa',
    rating: 4,
    category: Category.find_by(name: "Music")
  },

  {
    name: 'Dine in Lisbon',
    duration: 2,
    description: 'Experience authentic Portugues cuisine',
    address: 'Rua das Portas de Santo Antão 23, Lisboa',
    rating: 5,
    category: Category.find_by(name: "Points of Interest")
  }
]

events.each do |event|
  Event.create(event)
end
# Results
results = [
  {
    itinerary: Itinerary.first,
    event: Event.first
  },

  {
    itinerary: Itinerary.first,
    event: Event.last
}]

results.each do |result|
  Result.create(result)
end

puts 'Finished!'
