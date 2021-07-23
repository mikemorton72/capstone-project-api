class RemoveDateTimeFromRuns < ActiveRecord::Migration[6.1]
  def change
    remove_column :runs, :date_time, :datetime
  end
end
