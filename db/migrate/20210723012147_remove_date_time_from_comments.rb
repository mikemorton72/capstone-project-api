class RemoveDateTimeFromComments < ActiveRecord::Migration[6.1]
  def change
    remove_column :comments, :date_time, :datetime
  end
end
