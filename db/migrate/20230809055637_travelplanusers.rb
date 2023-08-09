class Travelplanusers < ActiveRecord::Migration[6.1]
  def change
    create_table :travelplanusers do |t|
      t.integer :user_id
      t.integer :travelplan_id

      t.timestamps
    end
  end
end
