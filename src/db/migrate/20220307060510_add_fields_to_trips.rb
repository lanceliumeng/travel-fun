class AddFieldsToTrips < ActiveRecord::Migration[6.1]
  def change
    add_column :trips, :brief_info, :text
    add_column :trips, :language, :string, default: "English", null: false
    add_column :trips, :duration, :string, default: "5-Days-4-Nights", null: false
    add_column :trips, :price, :integer, default: "0", null: false
  end
end
