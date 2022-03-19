class OrderPolicy < ApplicationPolicy
    class Scope < Scope
      # NOTE: Be explicit about which records you allow access to!
      def resolve
        scope.all
      end
    end

    def index?
        @user&.has_role?(:admin)  #only admin role can see the index view
    end
  
      def edit?  #gem pundit, similar setup as itinerary policy
         @record.user == @user  # when users object who match the trips creator object can edit, which means only the trip creator can do this action
      end
  
      def update?
        @record.user == @user # when users object who match the trips creator object can update
      end
  
      def destory?
        @user&.has_role?(:admin)  #only admin role can destory the records
      end
  
  end