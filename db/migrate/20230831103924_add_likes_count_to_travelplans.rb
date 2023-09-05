class AddLikesCountToTravelplans < ActiveRecord::Migration[6.1]
  def change
    add_column :travelplans, :likes_count, :integer, default: 0
  end
end
