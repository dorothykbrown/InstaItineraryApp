require 'json'
require 'open-uri'

class GooglePlacesService
  def self.search(itin_id)
    # return a list of places from google
    itinerary = Itinerary.find(itin_id)
    user = itinerary.user
    user.categories.each do |category|
      # output = "json"
      params = {
        key: ENV['GOOGLE_API_SERVER_KEY'],
        input: "art", # name, address or phone number, category.name
        # inputtype: "textquery", # can be either textquery or phone number
        fields: "formatted_address,place_id",
        # location: "circle:#{itinerary.search_radius}@#{itinerary.latitude},#{itinerary.longitude}"
      }
      # binding.pry
      search_url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{itinerary.latitude},#{itinerary.longitude}&radius=#{itinerary.search_radius}&keyword=#{params[:input]}&key=#{params[:key]}"
      # search_url = "https://maps.googleapis.com/maps/api/place/findplacefromtext/#{output}?input=#{params[:input]}&inputtype=#{params[:inputtype]}&fields=#{params[:fields]}&locationbias=#{params[:locationbias]}&key=#{params[:key]}"
      places_serialized = open(search_url).read
      # binding.pry
      places = JSON.parse(places_serialized)
      # binding.pry
      if places["status"] == "ZERO_RESULTS"
        return []
      else
        places["results"].each do |place|
          # place_address = places["candidates"].first["formatted_address"]
          place_id = place["place_id"]
          self.place_details(place_id, itin_id, category.id)
        end
      end
    end
    self.generate_itin(itin_id, itinerary.available_time)
  end

  def self.place_details(place_id, itin_id, cat_id)
    itinerary = Itinerary.find(itin_id)
    output = "json"
    params = {
      key: ENV['GOOGLE_API_SERVER_KEY'],
      place_id: place_id,
      fields: "opening_hours,icon,formatted_address,geometry/location,photos,price_level,rating,types,permanently_closed,reviews,website,url,id,name,place_id,plus_code,scope,user_ratings_total,vicinity"
    }
    details_url = "https://maps.googleapis.com/maps/api/place/details/#{output}?place_id=#{params[:place_id]}&fields=#{params[:fields]}&key=#{params[:key]}"
    event_serialized = open(URI::encode(details_url)).read
    event = JSON.parse(event_serialized)
    self.build_event(event, itin_id, cat_id)
  end

  def self.build_event(event, itin_id, cat_id)
    itinerary = Itinerary.find(itin_id)
    category = Category.find(cat_id)
    # estimated duration, in hours, of events based on event category
    event_duration = {
      'Music': 3,
      'Art and Architecture': 1,
      'Nature': 2,
      'Nightlife': 2,
      'Historical Sites': 1,
      'Points of Interest': 1
    }
    # binding.pry
    created_event = Event.create(
      name: event["result"]["name"],
      duration: event_duration[category.name],
      # description: "", ,
      address: event["result"]["formatted_address"],
      # photos: event["result"]["photos"],
      rating: event["result"]["rating"],
      price: event["result"]["price_level"], #price level
      # reviews: event["result"]["reviews"],
      website: event["result"]["website"],
      open_now: event["result"]["opening_hours"]["open_now"],
      # week_day_text: event["result"]["opening_hours"]["week_day_text"],
      category_id: cat_id
    )
    Result.create(event: created_event, itinerary: itinerary)
  end

  def self.generate_itin(itin_id, avail_time)
    itinerary = Itinerary.find(itin_id)
    itin_time = 0
    itin_event_results = []
    # binding.pry
    if itin_time < avail_time
      itinerary.events.each do |event|
        remain_time = avail_time - itin_time
        if event.duration.present? && event.duration < remain_time
          itin_event_results << event
          itin_time += event.duration
        end
      end
    end
    itin_event_results
  end
end
