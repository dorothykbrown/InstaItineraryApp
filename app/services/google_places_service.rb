require 'json'
require 'open-uri'

class GooglePlacesService
  def self.search(itin_id)
    # return a list of places from google
    itinerary = Itinerary.find(itin_id)
    user = itinerary.user
    user.categories.each do |category|
      output = "json"
      params = {
        key: ENV['GOOGLE_API_SERVER_KEY'],
        input: category.name, # name, address or phone number
        inputtype: "textquery", # can be either textquery or phone number
        fields: "formatted_address,place_id",
        locationbias: "circle:#{itinerary.search_radius}@#{itinerary.latitude},#{itinerary.longitude}"
      }
      search_url = "https://maps.googleapis.com/maps/api/place/findplacefromtext/#{output}?input=#{params[:input]}&inputtype=#{params[:inputtype]}&fields=#{params[:fields]}&locationbias=#{params[:locationbias]}&key=#{params[:key]}"
      binding.pry
      places_serialized = open(search_url).read
      places = JSON.parse(places_serialized)
      binding.pry
      place_address = places["candidates"].first["formatted_address"]
      binding.pry
      place_id = places["candidates"].first["place_id"]
      self.place_details(place_address, place_id, itin_id)
    end
    places
  end

  def self.place_details(place_address, place_id, itin_id)
    itinerary = Itinerary.find(itin_id)
    output = "json"
    params = {
      key: ENV['GOOGLE_API_SERVER_KEY'],
      place_id: place_id,
      fields: "opening_hours,icon,formatted_address,geometry/location,photos,price_level,rating,types,permanently_closed,reviews,website,url,id,name,place_id,plus_code,scope,user_ratings_total,vicinity"
    }
    binding.pry
    details_url = "https://maps.googleapis.com/maps/api/place/details/#{output}?place_id=#{params[:place_id]}&fields=#{params[:fields]}&key=#{params[:key]}"
    binding.pry
    event_serialized = open(URI::encode(details_url)).read
    binding.pry
    event = JSON.parse(event_serialized)
    binding.pry
    self.build_event(event, itin_id)
  end

  def self.build_event(event, itin_id)
    itinerary = Itinerary.find(itin_id)
    Event.create(
      name: event["result"]["name"],
      # duration: 2,
      # description: "", ,
      address: event[:formatted_address],
      rating: event[:rating],
      category_id: category.id
    )
    Result.create(event: event, itinerary: itinerary)
  end
end
