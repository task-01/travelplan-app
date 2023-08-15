class CreateTravelplans < ActiveRecord::Migration[6.1]
  def change
    create_table :travelplans do |t|
      t.string :travelplan_name
      t.string :prefecture_name
      t.string :tourist_spot
      t.integer :number_day
      t.text :content_chat
      t.text :gpt_response
      t.integer :user_id
      t.date :end_date
      t.date :start_date

      t.timestamps
    end
  end
end
