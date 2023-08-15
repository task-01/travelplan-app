class Travelplan < ApplicationRecord
  has_many :travelplan_users
  has_many :users, through: :travelplan_users, source: :user
end
