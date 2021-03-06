class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def index?
    @user&.has_role?(:admin) #only admin role can check other users status
  end

  def edit?
    @user&.has_role?(:admin) #only admin role can set other users roles
  end

  def update?
    @user&.has_role?(:admin)  #only admin role can set other users roles
  end
end
