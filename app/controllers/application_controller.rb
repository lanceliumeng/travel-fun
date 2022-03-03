class ApplicationController < ActionController::Base
    before_action :authenticate_user! #=> for user authentication by gem devise 
end
