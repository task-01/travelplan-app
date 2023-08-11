class User < ApplicationRecord
  has_many :travelplanusers
  has_many :join_travelplans, through: :travelplanusers, source: :travelplan

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
    end
  end

  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
end
