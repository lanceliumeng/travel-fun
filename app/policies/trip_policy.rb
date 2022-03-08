class TripPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

    def edit?
      (@user.has_role? :admin) || (@record.user == @user)  #only admin role can edit trips
    end

    def update?
      (@user.has_role? :admin) || (@record.user == @user)  #only admin role can update trips
    end

    def new?
      @user.has_role? :operator  #only operator role can create trips
    end

    def create?
      @user.has_role? :operator  #only operator role can create trips
    end

    def destory?
      @user.has_role? :admin  #only admin role can delete trips
    end

end
