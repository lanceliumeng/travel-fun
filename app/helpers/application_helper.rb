module ApplicationHelper
    #pagy gem set up
    include Pagy::Frontend  

    # this is for flash msg helper method, you can find it in views/shared/_messages.html.erb
    def select_alert_subclass(input)
        case input
        when 'notice'
            return 'success'
        when 'alert'
            return 'warning'
        when 'error'
            return 'danger'
        else
            return 'info'
        end
    end

    # this is for users role helper method, you can find it in views/users/_user.html.erb
    def select_role_color(input)
        case input
        when 'admin'
            return 'primary'
        when 'client'
            return 'success'
        when 'operator'
            return 'info'
        end
    end

    # these methods is for track activities front end style
    def activity_crud_icon(key)
        case key 
        when 'create'
            '<i class="fa-solid fa-circle-plus"></i>'.html_safe
        when 'update'
            '<i class="fa-solid fa-wrench"></i>'.html_safe
        when 'destroy'
            '<i class="fa-solid fa-eraser"></i>'.html_safe
        end
    end

    def model_icon(model)
        case model 
        when 'Trip'
            '<i class="fa-solid fa-map-location-dot"></i>'.html_safe
        when 'Itinerary'
            '<i class="fa fa-route"></i>'.html_safe
        end
    end

end
