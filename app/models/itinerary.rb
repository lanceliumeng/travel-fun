class Itinerary < ApplicationRecord
  # trips and itineraries table relationship
  belongs_to :trip, counter_cache: true  #=> The :counter_cache option can be used to make finding the number of belonging objects more efficient.
  #need run the command in rails console to reset counter: Trip.find_each { |trip| Trip.reset_counters(trip.id, :itineraries) }


  validates :title, :content, :trip, presence: true  #these columns cannot blank
  validates :title, uniqueness: true, length: { maximum: 20 } #itinerary title shold be unique and lenght cannot more than 20 words
  has_rich_text :content  #=> for rails action text, when we create new itinerary, content area has more powful function to edit text 

   # for firendly_id gem usage, after use this(another migration), the trip url doesn't show id, good for security
   extend FriendlyId
   friendly_id :title, use: :slugged

   # public_activity gem setup in trip model
   include PublicActivity::Model
   tracked owner: Proc.new{ |controller, model| controller.current_user }

   def to_s
    title
   end

end
