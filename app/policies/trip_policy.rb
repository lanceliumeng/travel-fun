class TripPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
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
