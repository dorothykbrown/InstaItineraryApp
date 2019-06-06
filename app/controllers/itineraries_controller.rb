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

    itin_results = GooglePlacesService.generate_itin(@itinerary.id)

    @itin_events = itin_results.first if itin_results.first.present?
    if @itin_events.nil?
      redirect_to root_path, notice: "No results were generated for this search. Please try again."
    else

      @itin_time = itin_results.last

      @itin_directions = MapboxNavService.direct(@itin_events)

    # binding.pry

      @markers = @itin_events.select { |mark| mark.longitude && mark.latitude }

      @markers.map!.with_index do |event, index|
        {
          lat: event.latitude,
          lng: event.longitude,
          infoWindow: render_to_string(partial: "info_window", locals: {
            property: event,
            index: index,
            last: index == @markers.length - 1
          })
        }
      end
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
      @search_error = true
      render '/pages/home'
    end
  end

  def create
    @itinerary = Itinerary.new(itinerary_params)
    @itinerary.user = current_user
    @itinerary.name = "#{@itinerary.location} - #{@itinerary.user.categories.map {|cat| cat.name}.join(", ")}"
    category_params
    authorize @itinerary

    if @itinerary.save
      flash[:success] = "Your itinerary parameters have been saved!"
      @itin_results = GooglePlacesService.search(@itinerary.id)
      redirect_to itinerary_path(@itinerary)
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
    if @itinerary.destroy
      redirect_to itineraries_path, notice: 'Itinerary was successfully removed.'
    else
      render :index, notice: 'You have no itineraries to remove.'
    end
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
    # get an array from the prevous form
    # on each create one
    UserCategory.new
  end

  def set_itinerary
    @itinerary = Itinerary.find(params[:id])
  end

  def category_params
    @user_categories = params[:categories].split(',')

    @user_categories.each do |category|
      cat = Category.find_by(name: category)
      # if current_user.categories.includes category
      UserCategory.create(category: cat, user: current_user)
    end
  end

  def itinerary_params
    params.require(:itinerary).permit(:location, :search_radius, :available_time, :name)
  end
end
