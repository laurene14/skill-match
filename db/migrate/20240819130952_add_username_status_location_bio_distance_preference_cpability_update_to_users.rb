class AddUsernameStatusLocationBioDistancePreferenceCpabilityUpdateToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :username, :string
    add_column :users, :admin, :boolean, default: false
    add_column :users, :address, :string
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float
    add_column :users, :bio, :string
    add_column :users, :distance_preference, :integer
    add_column :users, :capabilities_update, :timestamp
  end
end
