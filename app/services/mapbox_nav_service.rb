require "mapbox-sdk"

class MapboxNavService
  def self.direct(itin_id)
    itinerary = itinerary.find(itin_id)

    # profile: "mapbox/walking" #walking, driving, cycling, driving-traffic
    # coordinates:
  end

  # mapbox/driving-traffic
  # mapbox/driving
  # mapbox/walking
  # mapbox/cycling

  Mapbox.access_token = pk.eyJ1IjoicGF0cmljaWF2aWxhbHV6IiwiYSI6ImNqdmdqNm44cDAzZXM0YXF0NDdseTY3OGUifQ.2Rc2Q3D6hyyDMXSICyaBdw

  # Driving directions with required profile parameter.
  drivingDirections = Mapbox::Directions.directions([{
                                                       "longitude" => -100,
                                                       "latitude" => 38
                                                     }, {
                                                       "longitude" => -90,
                                                       "latitude" => 38
  }], "driving")

  # To provide query parameters to the Directions API, such as `geometries`, `language` or `steps`, add those in a Hash as third parameter (find the full list of parameters (here)[https://www.mapbox.com/api-documentation/navigation/#retrieve-directions]).

  # For instance, to use the `geometries` and `voice_instructions` parameter:
  drivingDirections = Mapbox::Directions.directions([{
                                                       "longitude" => -100,
                                                       "latitude" => 38
                                                     }, {
                                                       "longitude" => -90,
                                                       "latitude" => 38
                                                    }], "driving", {
                                                      geometries: "geojson",
                                                      voice_instructions: true
  })

  # In the above example, you can substitute `driving` for `driving-traffic`, `cycling` or `walking`. For more, [check out the documentation](https://www.mapbox.com/api-documentation/navigation/#directions).
end
