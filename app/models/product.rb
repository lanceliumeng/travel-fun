class Product < ApplicationRecord
    # set validations for product model, when fufill the product form, title and description cannot blank, description needs more than 5 chars.
    validates :title, presence: true
    validates :description, presence: true, length: {:minimum => 5 }
    belongs_to :user
    has_rich_text :description  #=> for rails action text

    def to_s
        title
    end
end
