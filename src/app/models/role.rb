class Role < ApplicationRecord
  validates :name, presence: true #role name cannot blank, and it shoule be also unique
  validates_uniqueness_of :name 
  # defalut for gem rolify
  has_and_belongs_to_many :users, :join_table => :users_roles
  
  belongs_to :resource,
             :polymorphic => true,
             :optional => true
  
  validates :resource_type,
            :inclusion => { :in => Rolify.resource_types },
            :allow_nil => true

  scopify
end
