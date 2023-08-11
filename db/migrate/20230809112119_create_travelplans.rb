class CreateTravelplans < ActiveRecord::Migration[6.1]
  def change
    create_table :travelplans do |t|
      t.string :travelplanName
      t.integer :user_id
      t.date :end_date
      t.date :start_date

      t.timestamps
    end
  end
end
