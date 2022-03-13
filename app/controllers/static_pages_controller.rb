class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :landing_page 
  #=> only for static page controller, cause I want users don't need sign in or sign up but still can check home page only(aka landing_page ).
  
  def landing_page
    # for landing_page (home page) propular and top rate trips
    @trips = Trip.all.limit(3)
    # for landing_page (home page) new trips :desc will loadying the new adds trips from DB
    @new_trips= Trip.all.limit(3).order(created_at: :desc)
    # for landing_page (home page) show brought trips
    @purchased_trips = Trip.joins(:orders).where(orders: {user: current_user}).order(created_at: :desc).limit(3)
    # for landing_page (home page) show popular trips
    @popluar_trips = Trip.order(orders_count: :desc, created_at: :desc).limit(3)
    # for landing_page (home page) show top rated trips
    @top_rated_trips = Trip.order(average_rating: :desc, created_at: :desc).limit(3)
  end

  # public_activity gem setup, puls track_activities views and routes, we can display uses CRUD history 
  def track_activities
    @activities = PublicActivity::Activity.all
  end

  def privacy_policy
  end
end
