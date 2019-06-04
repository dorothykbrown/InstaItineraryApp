require 'json'
require 'open-uri'

class GooglePlacesService
  def self.search(itin_id)
    # return a list of places from google
    itinerary = Itinerary.find(itin_id)
    user = itinerary.user
    # binding.pry

    # if user.categories == []
    #   # raise Exception.new("Please select a category")
    # else
      user.categories.each do |category|
        params = {
          key: ENV['GOOGLE_API_SERVER_KEY'],
          input: category.name, # name, address or phone number,
          inputtype: "textquery", # can be either textquery or phone number
          fields: "formatted_address,place_id",
          location: "circle:#{itinerary.search_radius}@#{itinerary.latitude},#{itinerary.longitude}"
        }
        # binding.pry
        search_url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{itinerary.latitude},#{itinerary.longitude}&radius=#{itinerary.search_radius}&keyword=#{params[:input]}&key=#{params[:key]}"
        # search_url = "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=#{params[:input]}&inputtype=#{params[:inputtype]}&fields=#{params[:fields]}&locationbias=#{params[:locationbias]}&key=#{params[:key]}"
        places_serialized = open(search_url).read
        places = JSON.parse(places_serialized)
        if places["status"] != "ZERO_RESULTS"
          places["results"].each do |place|
            # place_address = places["candidates"].first["formatted_address"]
            place_id = place["place_id"]
            self.place_details(place_id, itin_id, category.id)
          end
        end
      end
    # end
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
    # binding.pry
  end

  def self.build_event(event, itin_id, cat_id)
    itinerary = Itinerary.find(itin_id)
    category = Category.find(cat_id)
    # estimated duration, in hours, of events based on event category
    event_duration = {
      'Music': 2,
      'Art': 1,
      'Nature': 2,
      'Nightlife': 2,
      'History': 1,
      'Sightseeing': 1
    }
    created_event = Event.create(
      name: event.dig("result", "name"),
      duration: event_duration[category.name.to_sym],
      # description: "", ,
      address: event.dig("result", "formatted_address"),
      photo: find_event_photo(event.dig("result", "photos")),
      rating: event.dig("result", "rating"),
      price: event.dig("result", "price_level"), #price level
      # reviews: event["result"]["reviews"],
      website: event.dig("result", "website"),
      open_now: event.dig("result", "opening_hours", "open_now"),
      # week_day_text: event["result"]["opening_hours"]["week_day_text"],
      category_id: cat_id
    )
    Result.create(event: created_event, itinerary: itinerary)
  end

  def self.find_event_photo(photos)
    return nil if photos.nil?

    return nil if photos.empty?

    photo = photos.first

    params = {
      key: ENV['GOOGLE_API_SERVER_KEY'],
      ref: photo.dig("photo_reference"),
      height: photo.dig("height"),
      width: photo.dig("width")
    }

    "https://maps.googleapis.com/maps/api/place/photo?photoreference=#{params[:ref]}&sensor=false&maxheight=#{params[:height]}&maxwidth=#{params[:width]}&key=#{params[:key]}"
  end

  def self.generate_itin(itin_id)
    itinerary = Itinerary.find(itin_id)
    itin_time = 0
    itin_event_results = []
    if itin_time <= itinerary.available_time
      itinerary.events.each do |event|
        if event.latitude.present? && event.longitude.present?
          remain_time = itinerary.available_time - itin_time
          if event.duration.present? && event.duration <= remain_time
            itin_event_results << event
            itin_time += event.duration
          end
        end
      end
    end
    # binding.pry
    itin_event_results
    # binding.pry
  end
end
