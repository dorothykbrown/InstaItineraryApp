class ItinerariesController < ApplicationController
  before_action :set_itinerary, only: %i[show edit update destroy]

  def index
    if params[:category].present?
      @itineraries = policy_scope(Itinerary).where(user: current_user).where(category: params[:category]).where.not(latitude: nil, longitude: nil)
    else
      @itineraries = Itinerary.where("location ILIKE ?", "%#{params[:query]}%")
    end
  end
end

  def show
    authorize @itinerary

    @markers = @itinerary.events do |event|
    {
      lat: event.latitude,
      lng: event.longitude
    }
    end
  end

  def new
    @itinerary = Itinerary.new
  end

  def create

    @itinerary = Itinerary.new(itinerary_params)
    @itinerary.user = current_user
    authorize @itinerary

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
    authorize @itinerary
    if @itinerary.save
      redirect_to user_itinerary_path(@itinerary)
    else
      render :edit
    end
  end

  def destroy
    authorize @itinerary
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
