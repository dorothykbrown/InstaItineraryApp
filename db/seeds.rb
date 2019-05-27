# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Cleaning DB..."
User.destroy_all
Itinerary.destroy_all

puts "Creating Seeds..."
# User
 user_info = {
  email: "dorothy@whimaway.com",
  encrypted_password: "123456",
  name: "Dorothy"
}

user = User.create(user_info)

# Itinerary
itinerary_info = {
  location: "Lisbon, Portugal",
  search_radius: "5 km",
  available_time: 3, # hours
  name: "Lisbon Itinerary",
  user_id: user.id
}

Itinerary.create(itinerary_info)

puts "Finished!"
