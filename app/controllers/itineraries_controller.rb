class ItinerariesController < ApplicationController
  before_action :set_itinerary, only: %i[show edit update destroy]
  def index
    @itineraries = Itinerary.all

   @markers = @itineraries.map do |itinerary|
    {
      lat: itinerary.latitude,
      lng: itinerary.longitude#,
      # infoWindow: { content: render_to_string(partial: "/itinerarys/map_box", locals: { itinerary: itinerary }) }
      # Uncomment the above line if you want each of your markers to display a info window when clicked
      # (you will also need to create the partial "/itinerarys/map_box")
    }
  end

  def show
  end

  def new
    @itinerary = Itinerary.new
  end

  def create
    @itinerary = Itinerary.new(itinerary_params)
    if @itinerary.save
      redirect_to user_itinerary_path(@itinerary)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @itinerary = Itinerary.update(itinerary_params)
    if @itinerary.save
      redirect_to user_itinerary_path(@itinerary)
    else
      render :edit
    end
  end

  def destroy
    @itinerary.destroy
  end

  private

  def set_itinerary
    @itinerary = Itinerary.find(params[:id])
  end

  def itinerary_params
    params.require(:itinerary).permit(:location, :search_radius, :available_time, :name)
  end
end
