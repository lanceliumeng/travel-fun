class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :landing_page

  def landing_page
    # for landing_page (home page) propular and top rate trips
    @trips = Trip.all.limit(3)
    # for landing_page (home page) new trips :desc will loadying the new adds trips from DB
    @new_trips= Trip.all.limit(3).order(created_at: :desc)

  end

  def privacy_policy
  end
end
