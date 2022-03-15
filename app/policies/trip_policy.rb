class TripPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

    def show?  #this policy for security issue, if no this one, client user still can input trip url to find ununblished and unapproved trip
      # This way a user can see the trip if:
      (@record.published && @record.approved) ||  # it is published or approved OR
      (@user.present? && @user&.has_role?(:admin)) ||  # user is admin OR
      (@user.present? && @record.user == @user) ||  # user is the creator of the trip OR
      (@user.present? && @record.purchased(@user)) #the user purchased the trip (client)
    end 

    def edit?  #Ruby Safe navigation operator & can solve log out error bug =>  @user&.has_role?(:admin) = @user.present? && @user.has_role?:admin
      @user&.has_role?(:admin) || @record.user == @user  # only admin or when users object who match the trips creator object
    end

    def update?
      @record.user == @user  # when users object who match the trips creator object
    end

    def new?
      @user&.has_role?(:operator)  #only operator role can create trips
    end

    def create?
      @user&.has_role?(:operator)  #only operator role can create trips
    end

    def destory?
      @user&.has_role?(:admin) || @record.user == @user  #only admin role can delete trips or when users id who match the trips creator id
    end

    def owner?
      @record.user == @user
    end

    def approve? 
      @user&.has_role?(:admin)  #only admin role can approve the trips
    end
end
