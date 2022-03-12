class AddCounterCacheToModels < ActiveRecord::Migration[6.1]
  def change
    add_column :trips, :orders_count, :integer, null: false, default: 0
  end
end
# The :counter_cache option can be used to make finding the number of belonging objects more efficient. 