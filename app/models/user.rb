class User < ApplicationRecord
  has_many :travelplan_users
  has_many :travelplans, through: :travelplan_users, source: :travelplan
  has_many :likes
  has_many :liked_travelplans, through: :likes, source: :travelplan
  has_many :active_follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_follows, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_follows, source: :followed
  has_many :followers, through: :passive_follows, source: :follower
  has_one_attached :image

  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
  validates :password, presence: true, confirmation: true,
            length: { minimum: 6 }, if: :password_required?
  before_create :set_job_status_to_completed

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
    end
  end

  def guest_member?
    email == 'guest@example.com'
  end

  def likes?(travelplan)
    likes.exists?(travelplan_id: travelplan.id)
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_follows.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  private

  def password_required?
    !persisted? || password.present? || password_confirmation.present?
  end

  def set_job_status_to_completed
    self.job_status = "completed"
  end
end
