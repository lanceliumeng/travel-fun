class ItinerariesController < ApplicationController
  before_action :set_itinerary, only: [:show, :edit, :update, :destroy]

  # GET /itineraries or /itineraries.json
  def index
    @itineraries = Itinerary.all
  end

  # GET /itineraries/1 or /itineraries/1.json
  def show
    authorize @itinerary
  end

  # GET /itineraries/new
  def new
    @itinerary = Itinerary.new
    @trip = Trip.friendly.find(params[:trip_id])
  end

  # GET /itineraries/1/edit
  def edit
    authorize @itinerary 
  end

  # POST /itineraries or /itineraries.json
  def create
    @itinerary = Itinerary.new(itinerary_params)
    @trip = Trip.friendly.find(params[:trip_id])
    @itinerary.trip_id = @trip.id  #try to fix itinerary _form bugs, cannot create new itinerary

    respond_to do |format|
      if @itinerary.save
        # trip_itinerary_path(@trip, @itinerary) can fixed not path error
        format.html { redirect_to trip_itinerary_path(@trip, @itinerary), notice: "Itinerary was successfully created." }
        format.json { render :show, status: :created, location: @itinerary }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @itinerary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /itineraries/1 or /itineraries/1.json
  def update
    authorize @itinerary 
    respond_to do |format|
      if @itinerary.update(itinerary_params)
        # trip_itinerary_path(@trip, @itinerary) can fixed not path error
        format.html { redirect_to trip_itinerary_path(@trip, @itinerary), notice: "Itinerary was successfully updated." }
        format.json { render :show, status: :ok, location: @itinerary }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @itinerary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /itineraries/1 or /itineraries/1.json
  def destroy
    authorize @itinerary  #gem pundit setup authorize

    @itinerary.destroy
    respond_to do |format|
      format.html { redirect_to itineraries_url, notice: "Itinerary was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # use friendly_id gem to replace default .find
    def set_itinerary
      @trip = Trip.friendly.find(params[:trip_id])
      @itinerary = Itinerary.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def itinerary_params
      params.require(:itinerary).permit(:title, :content, :trip_id)
    end
end
