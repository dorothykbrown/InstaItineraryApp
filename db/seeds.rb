# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts 'cleaning DB!'

UserCategory.destroy_all
Review.destroy_all
Result.destroy_all
Event.destroy_all
Category.destroy_all
Itinerary.destroy_all
User.destroy_all

puts 'Creating Seeds...'

# Category
categories = [
  {
    name: 'Live Music',
    image_url: 'https://images.unsplash.com/photo-1429962714451-bb934ecdc4ec?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60',
  },

  {
    name: 'Art',
    image_url: 'https://images.unsplash.com/photo-1499781350541-7783f6c6a0c8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60',
  },

  {
    name: 'Parks',
    image_url: 'https://images.unsplash.com/photo-1453785675141-67637e2d4b5c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60'
  },

  {
    name: 'Nightlife',
    image_url: 'https://images.unsplash.com/photo-1519214605650-76a613ee3245?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60'
  },

  {
    name: 'Museums',
    image_url: 'https://images.unsplash.com/photo-1467383670897-225b16e3cc9a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60'
  },

  {
    name: 'Attractions',
    image_url: 'https://images.unsplash.com/photo-1542567455-cd733f23fbb1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60'
  }
]

categories.each do |category|
  cat = Category.create(category)
end


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

itineraries = [
  {
    location: 'Belem, Portugal',
    search_radius: 5, # km
    available_time: 5, # hours
    name: 'Belem Itinerary',
    transit_mode: 'walk'
  },
]

# Event

events = [
  {
    name: 'Tower of Belem',
    duration: 1,
    description: 'Landmark medieval fortified tower on Tagus River with rooftop terrace offering estuary views.',
    address: 'Avenida da Liberdade',
    rating: 4,
    category: Category.find_by(name: "Attractions"),
    latitude: 38.691667,
    longitude: -9.215977,
    price: 1,
    website: 'http://www.torrebelem.gov.pt/pt/index.php',
    photo: 'https://cdn.pixabay.com/photo/2017/02/21/18/05/lisbon-2086878_1280.jpg',
  },

  {
    name: 'Padrão dos Descobrimentos',
    duration: 2,
    description: 'Built in 1939 to honor the Portuguese Discoveries of the golden XV and XVI centuries.',
    address: 'Avenida Brasília, 1400-038 Lisboa',
    rating: 4,
    category: Category.find_by(name: "Attractions"),
    latitude: 38.693578,
    longitude: -9.205679,
    price: 1,
    website: 'https://padraodosdescobrimentos.pt/',
    photo: 'https://lisbonlisboaportugal.com/images/400pxbelem/padrao-dos-descobrimentos-belem-lisbon.jpg',
  },

    {
    name: 'Pastéis de Belém',
    duration: 1,
    description: 'In 1837 we began making the original Pastéis de Belém, following an ancient recipe from the Mosteiro dos Jerónimos.',
    address: 'Rua de Belém 84-92, 1300-085 Lisboa',
    rating: 5,
    category: Category.find_by(name: "Attractions"),
    latitude: 38.697527,
    longitude: -9.203195,
    price: 1,
    website: 'https://pasteisdebelem.pt/en/',
    photo: 'https://pasteisdebelem.pt/wp-content/uploads/2014/05/pastel_de_belem_caixa.jpg',
  }
]

users.each do |user|
  us = User.create!(user)
  itineraries.each do |it|
    it_attr = it.merge({user: us})
    itinerary = Itinerary.create(it_attr)
    if us.email == "dorothy@whimaway.com"
      events.each do |ev|
        event = Event.create!(ev)
        Result.create!(event: event, itinerary: itinerary)
      end
    end
  end

end

# Itinerary


# itineraries.each do |itin|
#   Itinerary.create!(itin)
# end




# events.each do |event|
#   Event.create(event)
# end
# # Results
# results = [
#   {
#     itinerary: Itinerary.first,
#     event: Event.first
#   },

#   {
#     itinerary: Itinerary.first,
#     event: Event.last
# }]

# results.each do |result|
#   Result.create(result)
# end

# # Results
# results = [
# {
#   itinerary: Itinerary.first,
#   event: Event.first
# },

# {
#   itinerary: Itinerary.first,
#   event: Event.last
# }]

# results.each do |result|
#   Result.create(result)
# end

# # User Categories
# user_categories = [
# {
#   user: User.first,
#   category: Category.all[0]
# },

# {
#   user: User.first,
#   category: Category.all[1]
# },

# {
#   user: User.first,
#   category: Category.all[2]

# }]

# user_categories.each do |user_cat|
#   UserCateogries.create(user_cat)
# end
puts 'Finished!'
