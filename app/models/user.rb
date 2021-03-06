class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  # rolify gem, command rails g rolify Role User, for user roles and authorization
  rolify

  #  then when you delete a user, all cars having that user_id will be deleted also

  # if set nullify, when a user delete the account, relates trips and orders will remain, but the user_id column will be set to null (it is pointless to have any value there because the user with that id was deleted)
  #users and trips table relationships
  has_many :trips, dependent: :nullify
  # users and orders table relationships
  has_many :orders, dependent: :nullify

  def to_s
    email
  end

  # for firendly_id gem usage, after use this(another migration), the user url doesn't show id, good for security
  extend FriendlyId
  friendly_id :email, use: :slugged

  #this method can split users email from @ symbol, eg, admin@test.com =>["admin", "test.com"]
  # so .first actually is [0], always choose index 0 element, kind of like username in my case
  def username
    self.email.split(/@/).first  
  end

  # public_activity gem setup in trip model
  include PublicActivity::Model
  tracked only: [:create, :destory], owner: :itself
  # tracked owner: Proc.new{ |controller, model| controller.current_user }

  # rolify gem assign default role
  after_create :assign_default_role

  def assign_default_role
    # self.add_role(:client) if self.roles.blank? => for default test, and it is working
    if User.count == 1 #=> when create the app, the first sign up user will be the admin role
      self.add_role(:admin) if self.roles.blank? 
      self.add_role(:operator)
      self.add_role(:client)
    else   #=> the other users role will be client and operator by default, waiting for update
      self.add_role(:client) if self.roles.blank? 
      # self.add_role(:operator) #=> after first account, all sign up account is client and operator role
    end
  end

  validate :must_have_a_role, on: :update  #each user must has at least a role


  def online?   #=> if user data was changed less than 2 mins, then user is online, this needs cooperate with views
    updated_at > 2.minutes.ago  #=> when a user logout 2 mins, then the user is offline, can check this logic in _user view
  end  
  
  def purchase_trip(trip)   #=> user can buy trip, will create a order,which includes current trip and current price for this current user
    self.orders.create(trip: trip, price: trip.price)
  end 


  private
  def must_have_a_role
    unless roles.any?
      errors.add(:roles, "user must have at least one role") #if edit user and doesn't have any role, will rise a notice
    end
  end


end
