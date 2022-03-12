class AddMoreCounterCacheFields < ActiveRecord::Migration[6.1]
  def change
    add_column :trips, :itineraries_count, :integer, null: false, default: 0 #add itineraries count into trips table
    add_column :users, :trips_count, :integer, null: false, default: 0 #add trips count into users table
    add_column :users, :orders_count, :integer, null: false, default: 0 #add orders count into users table
  end
end
# The :counter_cache option can be used to make finding the number of belonging objects more efficient. 