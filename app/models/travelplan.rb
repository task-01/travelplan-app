class Travelplan < ApplicationRecord
  has_many :travelplanusers
  has_many :users, through: :travelplanusers
end
