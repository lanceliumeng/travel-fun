class Trip < ApplicationRecord
    # set validations for trip model, when fufill the trip form, title and description cannot blank, description needs more than 5 chars.
    validates :title, :brief_info, :language,:price,:duration, presence: true
    validates :description, presence: true, length: {:minimum => 5 }
    belongs_to :user #users and trips table relationships
    has_rich_text :description  #=> for rails action text, when we create new trip, description area has more powful function to edit text 

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

end
