class ItinerariesController < ApplicationController
  before_action :set_itinerary, only: [:show, :edit, :update, :destroy]
  #=> only before show,edit,update and destory action, call back and picking set_itinerary action

  # GET all itineraries view page
  # Renders itineraries list view page. 
  def index
    @itineraries = Itinerary.all
  end

  # GET /itineraries/id view page
  #When the user selects this action, the controller will execute any code in the appropriate section - "def show" - and then by default will render a template of the same name - "show.html.erb".
  def show
   
  end

  # when we go to /itineraries/new route in my application to add new itinerary, Rails will reate an instance of ItinerariesController and call its new method
  def new 
    @itinerary = Itinerary.new
    @trip = Trip.friendly.find(params[:trip_id])
    authorize @itinerary #for only specific role(itinerary_policy.rb) can do this action
  end

  # GET /itineraries/1/edit page
  # Renders edit view to edit the target object with the supplied id.
  def edit
    authorize @itinerary  #for only specific role(itinerary_policy.rb) can do this action
  end

  # POST /itineraries
  # This action uses POST parameters. They are most likely coming
  # from an HTML form that the user has submitted. The URL for
  # this RESTful request will be "/itineraries", and the data will be
  # sent as part of the request body.
  def create
    @itinerary = Itinerary.new(itinerary_params)
    @trip = Trip.friendly.find(params[:trip_id])
    @itinerary.trip_id = @trip.id  #try to fix itinerary _form bugs, cannot create new itinerary
    authorize @itinerary #for only specific role(itinerary_policy.rb) can do this action
    respond_to do |format|
      if @itinerary.save  #=> If itinerary save, redirect to trip itinerary path
        # trip_itinerary_path(@trip, @itinerary) can fixed not path error
        format.html { redirect_to trip_itinerary_path(@trip, @itinerary), notice: "Itinerary was successfully created." }
        format.json { render :show, status: :created, location: @itinerary }
      else  #=> otherwise, render new page
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @itinerary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /itineraries/1 or /itineraries/1.json
  def update
    authorize @itinerary  #for only specific role(itinerary_policy.rb) can do this action
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
    authorize @itinerary  #gem pundit setup authorize , for only specific role(itinerary_policy.rb) can do this action

    @itinerary.destroy
    respond_to do |format|
      format.html { redirect_to trip_path(@trip), notice: "Itinerary was successfully destroyed." }
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
      params.require(:itinerary).permit(:title, :content) #delete :trip_id, cause if leave it in there, if hacker know the id, he can create a itinerary, at create action, I used .friendly method.
    end
end
