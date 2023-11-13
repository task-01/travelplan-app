class Travelplan < ApplicationRecord
  has_many :travelplan_users
  has_many :users, through: :travelplan_users, source: :user
  has_many :likes
  has_many :likers, through: :likes, source: :user

  has_one_attached :prefecture_image

  def fetch_gpt_response
    client = OpenAI::Client.new(access_token: ENV["CHATGPT_API_KEY"])
    # question = "#{content_chat}日次リスト形式"
    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo-0301",
        messages: [{ role: "user", content: "#{content_chat}日次リスト形式" }],
        temperature: 0.2,
      }
    )
    response.dig('choices', 0, 'message', 'content')
  end

  def like(travelplan)
    likes.create(travelplan_id: travelplan.id)
  end

  def unlike(travelplan)
    likes.find_by(travelplan_id: travelplan.id).destroy
  end

  def liked?(travelplan)
    liked_travelplans.include?(travelplan)
  end

  def self.top_liked_prefecture(limit: nil)
    select('travelplans.prefecture_name, COUNT(likes.id) as total_likes_count').
      joins(:likes).
      group('travelplans.prefecture_name').
      includes(:likes => :travelplan).
      order('total_likes_count DESC, travelplans.prefecture_name ASC').
      limit(limit)
  end

  scope :sorted_by_likes, -> {
    left_joins(:likes).
      select('travelplans.*, COUNT(likes.id) AS likes_count').
      group('travelplans.id').
      includes(:likes => :user).
      order('COUNT(likes.id) DESC')
  }

  def self.ransackable_attributes(options = {})
    %w(
      content_chat created_at end_date gpt_response job_status
      number_day prefecture_name start_date tourist_spot
      travelplan_name updated_at
    )
  end

  def self.ransackable_associations(options = {})
    %w(
      prefecture_image_attachment prefecture_image_blob
      travelplan_users users
    )
  end
end
