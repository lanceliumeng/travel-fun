class Trip < ApplicationRecord
    # set validations for trip model, when fufill the trip form, title and description cannot blank, description needs more than 5 chars.
    validates :title, :brief_info, :language,:price,:duration, presence: true
    validates :description, presence: true, length: {:minimum => 5 }
    #users and trips table relationships
    belongs_to :user, counter_cache: true  #=> The :counter_cache option can be used to make finding the number of belonging objects more efficient.
    #need run the command in rails console to reset counter: User.find_each { |user| User.reset_counters(user.id, :trips) }
    
    has_rich_text :description #=> for rails action text, when we create new trip, description area has more powful function to edit text 
    has_rich_text :brief_info #=> for rails action text, when we create new trip, brief info area has more powful function to edit text 
    has_many :itineraries, dependent: :destroy # trips and itineraries table relationship, if trip has some itineraries are deleted, the itineraries are also deleted
    has_many :orders, dependent: :restrict_with_error # trips and orders table relations, if any trip be ordered, it cannot be deleted

    validates :title, uniqueness: true 

    # define scopes for trips controller
    scope :published, -> { where(published: true) }
    scope :unpublished, -> { where(published: false) }
    scope :approved, -> { where(approved: true) }
    scope :unapproved, -> { where(approved: false) }

    has_one_attached :avatar  #=> for attaching files to Records, it sets up one to one mapping between records and files
    validates :avatar, attached: true, content_type: ['image/png', 'image/jpeg', 'image/jpg'], size: { less_than: 500.kilobytes , message: 'image size is too large, it should less than 5 MB' } 
    #=> for Active Storage Validations gem setup,only can upload images with 3 types, and cannot oversize

    def to_s
        title
    end
    
    # for firendly_id gem usage, after use this(another migration), the trip url doesn't show id, good for security
    extend FriendlyId
    friendly_id :title, use: :slugged

    # start: set LANGUAGES array, when trips index view call Trip.languages(selection),will use method self.lanaguages to mapping an new array which containa all available lanaguages 
    # Meanwhile, this method can let trips index view and _form view more readable
    LANGUAGES = [:"English", :"Chinese(Simplified)", :"Chinese(Traditional)", :"Korean", :"Japanese"]
    def self.languages
        LANGUAGES.map { |language| [language, language] }
    end

    DURATIONS = [:"5-Days", :"4-Days", :"3-Days", :"1-Day"]
    def self.durations
        DURATIONS.map { |duration| [duration, duration] }
    end
    # end

    # public_activity gem setup in trip model
    include PublicActivity::Model
    tracked owner: Proc.new{ |controller, model| controller.current_user }

    def purchased(user) 
        self.orders.where(user_id: [user.id], trip_id: [self.id]).any?
         #=> at this stage, I set a logic if current user didn't place any order , then the user can go ahead to buy.
         #=> eg, if a user joined a golf tour from tomorrow then the user only can join this specific tour during the exactly period
         #=> which means the user cannot join another different tour from tomorrow. 
    end

    #this method(order.rb file) allows when clients give new rating or update rating, it will update the average rating column for the trip
    # https://apidock.com/rails/ActiveRecord/Persistence/update_column
    def update_rating
        if orders.any? && orders.where.not(rating: nil).any?
            update_column :average_rating, (orders.average(:rating).round(2).to_f)
        else 
            update_column :average_rating, (0)
        end
    end
end
