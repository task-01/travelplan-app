class Travelplan < ApplicationRecord
  has_many :travelplan_users
  has_many :users, through: :travelplan_users, source: :user

  has_one_attached :prefecture_image
end
