class ChartsController < ApplicationController
    # for User Created line chart
    def users_per_day
      render json: User.group_by_hour(:created_at).count
    end
    # for Orders Created bar chart
    def orders_per_day
        render json: Order.group_by_day(:created_at).count
    end


end

# this controller can make analytics charts pages load super fast and stop worrying about timeouts. Give each chart its own endpoint.
# expecially when we have lots of data need to load, kind of like Eager Loading
 
