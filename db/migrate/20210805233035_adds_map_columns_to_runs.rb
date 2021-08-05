class AddsMapColumnsToRuns < ActiveRecord::Migration[6.1]
  def change
    add_column :runs, :start_latitude, :float
    add_column :runs, :start_longitude, :float
    add_column :runs, :summary_polyline, :string
    add_column :runs, :is_strava_import, :boolean
  end
end
