class Order < ApplicationRecord
  belongs_to :trip
  belongs_to :user
  
  #order model validations:
  validates :user,:trip, presence: true #there cannot be an order if it doesn't belong to a trip and a user
  validates_uniqueness_of :user_id, scope: :trip_id  #trip cannot be chooice by same user twice 
  validates_uniqueness_of :trip_id, scope: :user_id  #user cannot place order with same trip twice
  # in the furture, I want to add a calender system, so each client only can set one trip at same time.

  #if order has review then also need has rating, if an order has rating then also need has review
  validates_presence_of :rating, if: :review? 
  validates_presence_of :review, if: :rating? 


  # for firendly_id gem usage, after use this(another migration), the order url doesn't show id, good for security
  extend FriendlyId
  friendly_id :to_s, use: :slugged

  def to_s  #this method convert to string and it will be used in order edit view
    user.to_s + " " + trip.to_s
  end

  # this scope for trips controller pending_review action
  scope :pending_review, -> { where(rating: [0, nil, ""], review: [0, nil, ""])}

  #business logic: if user is company operator, they can create trip plan, but they cannot use that account to buy the trip.
  validate :cannot_buy_own_trip 
  protected
  def cannot_buy_own_trip
    if self.new_record?
      if self.user_id.present?  #extra if statement: to check if actually has an user id, otherwise when create new order will has an error user_id cannot be nil.
        if user_id == trip.user_id
          errors.add(:base, "Operator can not place the order!")
        end
      end
    end
end

end