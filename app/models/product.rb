class Product < ApplicationRecord
    # set validations for product model, when fufill the product form, title and description cannot blank, description needs more than 5 chars.
    validates :title, presence: true
    validates :description, presence: true, length: {:minimum => 5 }
    
    def to_s
        title
    end

    belongs_to :user

end
