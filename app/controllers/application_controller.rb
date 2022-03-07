class ApplicationController < ActionController::Base
    before_action :authenticate_user! #=> for user authentication by gem devise 
    # all of other controllers will inherit
end
