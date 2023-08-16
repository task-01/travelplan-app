class Travelplan < ApplicationRecord
  has_many :travelplan_users
  has_many :users, through: :travelplan_users, source: :user

  has_one_attached :prefecture_image

  def fetch_gpt_response
    client = OpenAI::Client.new(access_token: ENV["CHATGPT_API_KEY"])
    days_plan = (1..self.number_day).map { |day| "#{day}日目 朝食~, 午前~, 昼食, 午後, 夕方, 夕食, 宿泊" }.join(', ')
    question = "#{self.content_chat}の旅行プランを#{days_plan}の形式で全ての日数を1日つづ提案してください。"

    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: question }],
        temperature: 0.2,
      }
    )
    response.dig('choices', 0, 'message', 'content')
  end
end
