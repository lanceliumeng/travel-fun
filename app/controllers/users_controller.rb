class UsersController < ApplicationController
    def index
        # @users = User.all.order(created_at: :desc)
        # Ransack gem for for searching/filtering users
        @q = User.ransack(params[:q])
        @users = @q.result(distinct: true)
    end
end