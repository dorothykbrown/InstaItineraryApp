require "mapbox-sdk"
Mapbox.access_token = ENV['MAPBOX_API_KEY']

class MapboxNavService
  def self.direct(itin_array)
    # itinerary = Itinerary.find(itin_id)
    events = itin_array

    profile = "walking"

    if events.size > 1
      profile = "walking"
        coordinates_array = events.map do |event|
          "#{event.latitude},#{event.longitude};" # -122.42,37.78;-77.03,38.91
        end
        direction_search_url = "https://api.mapbox.com/directions/v5/mapbox/#{profile}/#{coordinates_array.join}?access_token=pk.eyJ1IjoiZG9yb3RoeWticm93biIsImEiOiJjanY4NDBjdHQwMW50NGRwN2ozNGRtc2RhIn0.jrku3I-l-iAula54PdsEDg"
      # To provide query parameters to the Directions API, such as `geometries`, `language` or `steps`, add those in a Hash as third parameter (find the full list of parameters (here)[https://www.mapbox.com/api-documentation/navigation/#retrieve-directions]).

      # For instance, to use the `geometries` and `voice_instructions` parameter:
      event_coordinates = events.map do |event|
        next if event.longitude.blank? || event.latitude.blank?

        {
          "longitude" => event.longitude,
          "latitude" => event.latitude
        }
      end.compact

      Mapbox::Directions.directions(
        event_coordinates,
        "walking", {
          geometries: "geojson",
          steps: true,
          banner_instructions: false,
          voice_instructions: false,
          language: 'en',
          roundabout_exits: false,
          voice_units: 'metric'
        }
      )
    else
      []
    end
  end

  def self.direct_a_to_b(starting, ending)
    profile = "walking"
    coordinates = "#{starting.latitude},#{starting.longitude};#{ending.latitude},#{ending.longitude};"
    direction_search_url = "https://api.mapbox.com/directions/v5/mapbox/#{profile}/#{coordinates}?access_token=pk.eyJ1IjoiZG9yb3RoeWticm93biIsImEiOiJjanY4NDBjdHQwMW50NGRwN2ozNGRtc2RhIn0.jrku3I-l-iAula54PdsEDg"

    event_coordinates = coordinates.split(';')

    event_coordinates.map! do |event|
      next if event.split(',')[0].blank? || event.split(',')[1].blank?

      {
        "longitude" => event.split(',')[1].to_f,
        "latitude" => event.split(',')[0].to_f
      }
    end.compact

    Mapbox::Directions.directions(
      event_coordinates,
      "walking", {
        geometries: "geojson",
        steps: true,
        banner_instructions: false,
        voice_instructions: false,
        language: 'en',
        roundabout_exits: false,
        voice_units: 'metric'
      }
    )
  end
  # In the above example, you can substitute `driving` for `driving-traffic`, `cycling` or `walking`. For more, [check out the documentation](https://www.mapbox.com/api-documentation/navigation/#directions).
end
