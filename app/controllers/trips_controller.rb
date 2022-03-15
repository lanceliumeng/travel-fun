class TripsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show  #even user don't log in, the user still can check trip show page
  before_action :set_trip, only: [:show, :edit, :update, :destroy, :approve, :unapprove, :analytics]

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
    @ransack_path = trips_path
    # for _trip view, only can see the trips if them are published and approved
    @ransack_trips = Trip.published.approved.ransack(params[:trips_search], search_key: :trips_search)
    @pagy, @trips = pagy(@ransack_trips.result.includes(:user))  # gem pagy set up
    render 'index'
  end

  #def brought action when client user purchased the trip 
  # when current user is operator, if the user do search, then only can search the trips belongs to him, not for all trips
  def brought
    @ransack_path = brought_trips_path
    @ransack_trips = Trip.joins(:orders).where(orders: {user: current_user}).ransack(params[:trips_search], search_key: :trips_search)
    @pagy, @trips = pagy(@ransack_trips.result.includes(:user))
    render 'index'
  end

  #def pending review action when client brought a trip but the trip didn't has a review
  def pending_review
    @ransack_path = pending_review_trips_path
    @ransack_trips = Trip.joins(:orders).merge(Order.pending_review.where(user: current_user)).ransack(params[:trips_search], search_key: :trips_search)
    @pagy, @trips = pagy(@ransack_trips.result.includes(:user))
    render 'index'
  end

  # def designed trip action for operator use who has created the travel plan
  def designed
    @ransack_path = designed_trips_path
    @ransack_trips = Trip.where(user: current_user).ransack(params[:trips_search], search_key: :trips_search)
    @pagy, @trips = pagy(@ransack_trips.result.includes(:user))
    render 'index'
  end

   # def unapproved trip action for admin can check if there are any trips status is unapprove
   def unapproved
    @ransack_path = unapproved_trips_path
    @ransack_trips = Trip.unapproved.ransack(params[:trips_search], search_key: :trips_search)
    @pagy, @trips = pagy(@ransack_trips.result.includes(:user))
    render 'index'
  end

  # start: all trips need admin to check then decide they can be approved or not
  def approve
    authorize @trip, :approve?  #for only damin role(trip_policy.rb) can do this action
    @trip.update_attribute(:approved, true)
    redirect_to @trip, notice: "Trip is approved and now it can be visible."
  end

  def unapprove
    authorize @trip, :approve?  #for only damin role(trip_policy.rb) can do this action
    @trip.update_attribute(:approved, false)
    redirect_to @trip, notice: "Trip is unapproved and the creator needs to double check details."
  end
  #end

  def analytics
    authorize @trip, :analytics? #for analytics policy
  end


  # set variable to collect itineraries,display it in trips show page
  def show
    authorize @trip #for show policy security
    @itineraries = @trip.itineraries
    @orders_with_reviews = @trip.orders.reviewed #reviewed is already setup scope in order model
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
    # if no any orders relate with trip, then the trip can be deleted
      if @trip.destroy
        respond_to do |format|
        format.html { redirect_to trips_url, notice: "Trip was successfully destroyed." }
        format.json { head :no_content }
        end
    # else the trip cannot be deleted
      else
        redirect_to @trip, alert: "The trip cannot be deleted cause there are some relate orders "
      end
  end

  private
    # use friendly_id gem to replace default .find
    def set_trip
      @trip = Trip.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def trip_params
      params.require(:trip).permit(:title, :description, :brief_info, :published, :language, :duration, :price, :avatar)
    end
end
