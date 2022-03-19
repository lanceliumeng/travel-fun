class AddAverageRatingToTrips < ActiveRecord::Migration[6.1]
  def change
    add_column :trips, :average_rating, :float, default: 0.0, null: false
  end
end
