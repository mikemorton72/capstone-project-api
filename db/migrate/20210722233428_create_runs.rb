class CreateRuns < ActiveRecord::Migration[6.1]
  def change
    create_table :runs do |t|
      t.integer :user_id
      t.string :title
      t.decimal :distance, precision: 19, scale: 2
      t.integer :elapsed_time
      t.datetime :date_time

      t.timestamps
    end
  end
end
