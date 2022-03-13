module TripsHelper
   #can find this method on trip partial view
    def order_button(trip)
        #buy logic
        if current_user 
            if trip.user == current_user  #=> if current user who created the trip, then cannot buy and go to check analytics for marketing
                link_to "You created the trip, please go to check analytics", trip_path(trip)
            elsif trip.orders.where(user: current_user).any?  #=> client user already bought the trip
                link_to "You have bought the trip, enjoy your trip",trip_path(trip)
            elsif trip.price > 0 #=> if trip price is not 0 then can click price button and make payment
                link_to number_to_currency(trip.price), new_trip_order_path(trip), class: 'btn btn-success'
            else #=> test logic: if trip is free, then also has the logic can join the free trip
                link_to "Free", new_trip_order_path(trip), class: 'btn btn-primary'
            end
            #buy logic
        else
            link_to "Check Price", trip_path(trip), class: 'btn btn-md btn-success'
        end
    end

    def review_button(trip)
        user_trip = trip.orders.where(user: current_user)  #=> make suer the current user order trip and trip match
        if current_user
            if user_trip.any? #=> if current user has ordered the trip
                if user_trip.where(rating:[0, nil, ""], review:[0, nil, ""]).any? #=> if they don't leave any review and rating, then can add review
                    link_to edit_order_path(user_trip.first) do
                        "<i class='fa-brands fa-gratipay text-danger'></i>".html_safe + " " +
                        "<i class='fa-solid fa-pen-to-square text-info'></i>".html_safe + " " +
                        'Add a review'
                    end
                else  #=> else give them plain text to notice, in the furture, I want to add user can edit their reviews
                    link_to order_path(user_trip.first) do
                        "<i class='fa-solid fa-heart text-danger'></i>".html_safe + " " +
                        "<i class='fa-solid fa-circle-check text-success'></i>".html_safe + " " +
                        'Thanks for your review'
                    end
                end
            end
        end
    end


end
