class TravelsController < ApplicationController
  def home
  end

  def index
    @query = params[:query]

    response = @client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: @query }],
      }
    )

    @travels = response.dig("choices", 0, "message", "content")
  end
end
