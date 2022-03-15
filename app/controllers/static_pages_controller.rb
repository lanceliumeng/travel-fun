class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :landing_page 
  #=> only for static page controller, cause I want users don't need sign in or sign up but still can check home page only(aka landing_page ).
  
  def landing_page
    # for landing_page (home page) propular and top rate trips
    @trips = Trip.all.limit(3)
    # for landing_page (home page) new trips :desc will loadying the new adds trips from DB,only show pass published and approved trips
    @new_trips= Trip.all.limit(3).order(created_at: :desc).published.approved
    # for landing_page (home page) show brought trips
    @purchased_trips = Trip.joins(:orders).where(orders: {user: current_user}).order(created_at: :desc).limit(3)
    # for landing_page (home page) show popular trips,only show pass published and approved trips
    @popluar_trips = Trip.order(orders_count: :desc, created_at: :desc).limit(3).published.approved
    # for landing_page (home page) show top rated trips,only show pass published and approved trips
    @top_rated_trips = Trip.order(average_rating: :desc, created_at: :desc).limit(3).published.approved
  end

  # public_activity gem setup, puls track_activities views and routes, we can display users CRUD history
  # only admin user can check this page
  def track_activities
    if current_user.has_role?(:admin)
      # let track_activities order always start from the newest created time at front end page
      @pagy, @activities = pagy(PublicActivity::Activity.all.order(created_at: :desc))
    else
      redirect_to root_path, alert: "You don't have authorization to check this page"
    end
  end

  # for analytics view call, only admin role can check this view
  def analytics
    if current_user.has_role?(:admin)
      @users = User.all
      @orders = Order.all
      @trips = Trip.all
    else 
      redirect_to root_path, alert: "You don't have authorization to check this page"
    end
  end

  def privacy_policy
  end
end
