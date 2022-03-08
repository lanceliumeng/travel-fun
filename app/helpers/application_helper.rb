module ApplicationHelper
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


end
