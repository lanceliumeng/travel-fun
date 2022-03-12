class TripPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

    def edit?  #Ruby Safe navigation operator & can solve log out error bug =>  @user&.has_role?(:admin) = @user.present? && @user.has_role?:admin
      @user&.has_role?(:admin) || @record.user == @user  #only admin role can edit trips or when users id who match the trips creator id
    end

    def update?
      @user&.has_role?(:admin) || @record.user == @user  #only admin role can update trips or when users id who match the trips creator id
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
end
