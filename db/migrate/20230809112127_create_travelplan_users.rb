class CreateTravelplanUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :travelplan_users do |t|
      t.integer :user_id
      t.integer :travelplan_id

      t.timestamps
    end
  end
end
