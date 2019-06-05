# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts 'cleaning DB!'

Result.destroy_all
Event.destroy_all
Category.destroy_all
UserCategory.destroy_all
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
    available_time: 4, # hours
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
    address: 'Avenida Brasília, 1400-038 Lisboa',
    rating: 4,
    category: Category.find_by(name: "Sightseeing"),
    price: 1,
    website: 'http://www.torrebelem.gov.pt/pt/index.php',
    photo: 'data:image/jpeg;base64,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',
  },

  {
    name: 'Jerónimos Monastery',
    duration: 2,
    description: 'Late Gothic Manueline-style monastery housing archaeology & maritime museums in its wings.',
    address: 'Praça do Império 1400-206 Lisboa',
    rating: 4,
    category: Category.find_by(name: "History"),
    price: 1,
    website: 'http://www.mosteirojeronimos.gov.pt/pt/index.php',
    photo: 'https://lh6.googleusercontent.com/proxy/RmRy1nQEz65aNBpenwWJ225azO1ar2IRt5Ly9cGFsKzP5GCM1p0x_66aGAp5ZQKpJZkqNj5K8l7lrknv6Df-5NlIix747yWplpO8BnR1VMjdPgA5yUi9EAse-Plq_V8_NHui5MpElQz3cli7bZMezwq3IUQ=w200-h268-n-k-no',
  },

    {
    name: 'Pastéis de Belém',
    duration: 1,
    description: 'In 1837 we began making the original Pastéis de Belém, following an ancient recipe from the Mosteiro dos Jerónimos.',
    address: 'Rua de Belém 84-92, 1300-085 Lisboa',
    rating: 5,
    category: Category.find_by(name: "Sightseeing"),
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
    events.each do |ev|
      event = Event.create(ev)
      Result.create(event: event, itinerary: itinerary)
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
