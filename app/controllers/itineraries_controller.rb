class ItinerariesController < ApplicationController
  before_action :set_itinerary, only: %i[show edit update destroy]
  # before_action :build_user_cat, only: [:index]

  def index
    if params[:category].present?
      @itineraries = policy_scope(Itinerary).where(category: params[:category]).where.not(latitude: nil, longitude: nil)
    else
      @itineraries = policy_scope(Itinerary).where("location ILIKE ?", "%#{params[:query]}%")
    end
  end

  def show
    authorize @itinerary

    @markers = @itinerary.events.map do |event|
     {
      lat: event.latitude,
      lng: event.longitude,
      infoWindow: render_to_string(partial: "info_window", locals: { property: event })
    }
  end
end


def new
  @itinerary = Itinerary.new
  authorize @itinerary
  if params[:query].present?
    @search = Geocoder.search(params[:query])
    if @search == []
      flash[:notice] = "No Search Results for that location"
      redirect_to root_path
    else
      @first_result = @search.first
      render_markers
    end
  else
    @search = Geocoder.search("lisbon")
    @first_result = @search.first
    render_markers
  end
end

def create
  @itinerary = Itinerary.new(itinerary_params)
  @itinerary.user = current_user
  authorize @itinerary

  if @itinerary.save
    flash[:success] = "Your itinerary parameters have been saved!"
    redirect_to user_itinerary_path(current_user, @itinerary)
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


def render_markers
  @markers = [
    {
      lat: @first_result.latitude,
      lng: @first_result.longitude,
      infoWindow: render_to_string(partial: "new_window", locals: { search: @search.first.display_name })
    }
  ]
end

def build_user_cat
    #get an array from the prevous form
    #on each create one
    UserCategory.new
  end

  def set_itinerary
    @itinerary = Itinerary.find(params[:id])
  end

  def itinerary_params
    params.require(:itinerary).permit(:location, :search_radius, :available_time, :name)
  end
end
