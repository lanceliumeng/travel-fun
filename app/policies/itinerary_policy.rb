class ItineraryPolicy < ApplicationPolicy
    class Scope < Scope
      # NOTE: Be explicit about which records you allow access to!
      def resolve
        scope.all
      end
    end

    def show?
        @user&.has_role?(:admin) || @record.trip.user == @user #only admin role can edit trips or when users id who match the trips creator id
    end
  
      def edit?  #gem pundit, similar setup as trip policy
         @record.trip.user == @user  # when users id who match the trips creator id can edit
      end
  
      def update?
        @record.trip.user == @user # when users id who match the trips creator id can update
      end
  
      def new?
        # @user&.has_role?(:operator)  #only operator role can create trips
      end
  
      def create?
        # @user&.has_role?(:operator)  #only operator role can create trips
      end
  
      def destory?
        @record.trip.user == @user  # when users id who match the trips creator id can delete
      end
  
  end