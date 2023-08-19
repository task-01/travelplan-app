class Travelplan < ApplicationRecord
  has_many :travelplan_users
  has_many :users, through: :travelplan_users, source: :user

  has_one_attached :prefecture_image

  def fetch_gpt_response
    client = OpenAI::Client.new(access_token: ENV["CHATGPT_API_KEY"])
    question = "#{self.content_chat}の日次の旅行プランをリスト形式で教えてください。"

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
