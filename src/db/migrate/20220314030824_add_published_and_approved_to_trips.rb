class AddPublishedAndApprovedToTrips < ActiveRecord::Migration[6.1]
  def change
    add_column :trips, :published, :boolean, default: false
    add_column :trips, :approved, :boolean, default: false
  end
end

# add two fields into trips table, each trip be created then needs to be approved by admin, and publish eby creater