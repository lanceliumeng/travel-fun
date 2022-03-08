class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update]

    def index
        # @users = User.all.order(created_at: :desc)
        
        # Ransack gem for for searching/filtering users
        @q = User.ransack(params[:q])
        @users = @q.result(distinct: true)
    end

    #set a method can edit users roles, commited the method cause I update befor_action for the controller
    def edit
        # @user = User.find(params[:id])
    end

    #set a method can update users roles
    def update
        if @user.update(user_params)
            redirect_to users_path, notice: "You have successfully updated the role for #{@user.email}."
          else
            render :edit
        end
    end

    private

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit({role_ids: []})
    end

end