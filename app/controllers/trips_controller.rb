class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]

  # index action, trips_path will show all trips to browser.
  def index
    # for search function, eg: users typed tas for searching,
    # in my server, GET "/trips?search_title=tas" for 127.0.0.1,  Parameters: {"title"=>"tas"}, back end will check the DB:
    # SELECT "trips".* FROM "trips" WHERE (lower(title) LIKE '%tas%'), if it can find sth match, then display match things to front end views
    # else, display all trips at views
    # The lower() method converts the field on the database side to lowercase.
    # Calling params[:title].downcase converts the provided search term to lowercase also.
    # Array conditions prevent SQL injection in Active Record (sanitize).
    # if params[:title]
    #   @trips = Trip.where("lower(title) LIKE ?", "%#{params[:title].downcase}%")
    # else
    #   @trips = Trip.all
    # end
    # Ransack gem for for searching/filtering users
    # @q = Trip.ransack(params[:q])
    # @trips = @q.result.includes(:user)
    # end
    
    #thrid update, because used ransack gem, and set set_navbar_search method at application controller
    # so need to change above default @q variable to same as set_navbar_search method variable
    @ransack_trips = Trip.ransack(params[:trips_search], search_key: :trips_search)
    @trips = @ransack_trips.result.includes(:user)

  end

  # GET /trips/1 or /trips/1.json
  def show
  end

  # GET /trips/new
  def new
    @trip = Trip.new
    authorize @trip  #for only specific role(trip_policy.rb) can do this action
  end

  # GET /trips/1/edit
  def edit
    authorize @trip #for only specific role(trip_policy.rb) can do this action
  end

  # POST /trips or /trips.json
  def create
    @trip = Trip.new(trip_params)
    authorize @trip #for only specific role(trip_policy.rb) can do this action

    #=> start: we have created a relationship between the user model and trip model
    @trip.user = current_user   
    #=> end: when we create new trip, it will automatically belongs to the current user account
    respond_to do |format|
      if @trip.save
        format.html { redirect_to trip_url(@trip), notice: "Trip was successfully created." }
        format.json { render :show, status: :created, location: @trip }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trips/1 or /trips/1.json
  def update
    authorize @trip #for only specific role(trip_policy.rb) can do this action
    respond_to do |format|
      if @trip.update(trip_params)
        format.html { redirect_to trip_url(@trip), notice: "Trip was successfully updated." }
        format.json { render :show, status: :ok, location: @trip }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trips/1 or /trips/1.json
  def destroy
    authorize @trip #for only specific role(trip_policy.rb) can do this action
    @trip.destroy
  
    respond_to do |format|
      format.html { redirect_to trips_url, notice: "Trip was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # use friendly_id gem to replace default .find
    def set_trip
      @trip = Trip.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def trip_params
      params.require(:trip).permit(:title, :description, :brief_info, :language, :duration, :price)
    end
end
