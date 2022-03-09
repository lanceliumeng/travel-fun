class Itinerary < ApplicationRecord
  belongs_to :trip # trips and itineraries table relationship
  validates :title, :content, :trip, presence: true  #these columns cannot blank

   # for firendly_id gem usage, after use this(another migration), the trip url doesn't show id, good for security
   extend FriendlyId
   friendly_id :title, use: :slugged
   
end
