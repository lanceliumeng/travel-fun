class Trip < ApplicationRecord
    # set validations for trip model, when fufill the trip form, title and description cannot blank, description needs more than 5 chars.
    validates :title, presence: true
    validates :description, presence: true, length: {:minimum => 5 }
    belongs_to :user
    has_rich_text :description  #=> for rails action text

    def to_s
        title
    end
    
    # for firendly_id gem usage
    extend FriendlyId
    friendly_id :title, use: :slugged
end
