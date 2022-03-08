class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  # rolify gem, command rails g rolify Role User, for user roles and authorization
  rolify
  #users and trips table relationships
  has_many :trips 

  def to_s
    email
  end

  #this method can split users email from @ symbol, eg, admin@test.com =>["admin", "test.com"]
  # so .first actually is [0], always choose index 0 element, kind of like username in my case
  def username
    self.email.split(/@/).first  
  end

  # rolify gem assign default role
  after_create :assign_default_role

  def assign_default_role
    # self.add_role(:client) if self.roles.blank? => for default test, and it is working
    if User.count == 1 #=> when create the app, the first sign up user will be the admin role
      self.add_role(:admin) if self.roles.blank? 
      self.add_role(:operator)
      self.add_role(:client)
    else 
      self.add_role(:client) if self.roles.blank? 
      self.add_role(:operator)
    end
  end

end
