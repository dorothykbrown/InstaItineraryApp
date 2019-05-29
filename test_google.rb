

# category
# possible categories: food, natural_feature, point_of_interest, night_club, aquarium, amusement_park
# , art_gallery, bowling_alley, campground, casino, movie_theater, museum, park, restaurant, shopping_mall,
# spa, stadium, cafe
# Search point of interest in Lisbon with 10 km search radius
# user_attr = {
#   email: 'dorothy@whimaway.com',
#   password: '123456',
#   name: 'Dorothy'
# }
user = User.find_by(email: 'dorothy@whimaway.com')

categories = [
  {
    name: 'Music'
  },

  {
    name: 'Art and Architecture'
  },

  {
    name: 'Nature'
  },

  {
    name: 'Nightlife'
  },

  {
    name: 'Historical Sites'
  },

  {
    name: 'Points of Interest'
  }
]

categories.each do |category|
  Category.create(category)
end

user_categories = [
{
  user: user,
  category: Category.all[0]
},

{
  user: user,
  category: Category.all[1]
},

{
  user: user,
  category: Category.all[2]

}]

ittn_attr = {
  location: 'Lisbon, Portugal',
  search_radius: 10,
  available_time: 3, # hours
  name: 'Lisbon Itinerary',
  user: user
}
itinerary = Itinerary.new(ittn_attr)
itinerary.save

GooglePlacesService.search(itinerary.id)
