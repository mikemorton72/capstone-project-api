class AddStravaIdToRuns < ActiveRecord::Migration[6.1]
  def change
    add_column :runs, :strava_id, :integer
  end
end
