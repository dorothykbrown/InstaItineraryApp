class EventsController < ApplicationController
  def index
    @itinerary = Itinerary.find(params[:id])
    @events = @itinerary.events
    @events = Event.where.not(latitude: nil, longitude: nil)
    @markers = @events.map do |event|
    {
      lat: event.latitude,
      lng: event.longitude
      # infoWindow: { content: render_to_string(partial: "/events/map_box", locals: { event: event }) }
      # Uncomment the above line if you want each of your markers to display a info window when clicked
      # (you will also need to create the partial "/events/map_box")
    }
  end

  def show
    @event = Event.find(params[:id])
  end
end
