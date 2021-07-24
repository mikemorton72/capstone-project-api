class AddStravaTokensToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :strava_access_token, :string
    add_column :users, :strava_refresh_token, :string
    add_column :users, :strava_access_expiration, :datetime
  end
end
