class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  has_many :trips #users and trips table relationships
  

  def to_s
    email
  end

  def username
    self.email.split(/@/).first  
    #this method can split users email from @ symbol, eg, admin@test.com =>["admin", "test.com"]
    # so .first actually is [0], always choose index 0 element, kind of like username in my case
  end

end
