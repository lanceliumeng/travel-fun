class CreateItineraries < ActiveRecord::Migration[6.1]
  def change
    create_table :itineraries do |t|
      t.string :title
      t.text :content
      t.references :trip, null: false, foreign_key: true

      t.timestamps
    end
  end
end
