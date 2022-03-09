class Itinerary < ApplicationRecord
  belongs_to :trip # trips and itineraries table relationship
  validates :title, :content, :trip, presence: true  #these columns cannot blank

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
