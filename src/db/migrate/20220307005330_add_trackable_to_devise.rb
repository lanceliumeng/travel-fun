class AddTrackableToDevise < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :sign_in_count, :integer, default: 0, null: false
    add_column :users, :current_sign_in_at, :datetime
    add_column :users, :last_sign_in_at, :datetime
    add_column :users, :current_sign_in_ip, :inet
    add_column :users, :last_sign_in_ip, :inet
  end
end

# rails g migration add_trackable_to_devise
# fellow the docs setup
# https://github-wiki-see.page/m/heartcombo/devise/wiki/How-To:-Add-:trackable-to-Users
# https://github.com/heartcombo/devise/wiki/How-To%3A-Add-%3Atrackable-to-Users
# and then run rails db:migrate to migrate the above columns to users table (schema.rb file)