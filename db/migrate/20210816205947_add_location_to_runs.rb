class AddLocationToRuns < ActiveRecord::Migration[6.1]
  def change
    add_column :runs, :location_name, :string
  end
end
