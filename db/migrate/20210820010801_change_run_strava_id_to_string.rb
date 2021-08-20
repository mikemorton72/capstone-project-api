class ChangeRunStravaIdToString < ActiveRecord::Migration[6.1]
  def change
    change_column :runs, :strava_id, :string
  end
end
