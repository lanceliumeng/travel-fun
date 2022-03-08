class ApplicationController < ActionController::Base
    before_action :authenticate_user! #=> for user authentication by gem devise 
    # all of other controllers will inherit
    
    before_action :set_navbar_search, if: :user_signed_in?
    def set_navbar_search
      @ransack_trips = Trip.ransack(params[:trips_search], search_key: :trips_search) 
    end
    # after users signed in, they can use navbar search as well! 

    include PublicActivity::StoreController #save current_user using gem public_activity
end
