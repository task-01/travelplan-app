class TravelsController < ApplicationController
  before_action :authenticate_user!, except: :home
  def home
    # @user = current_user.id
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

  def show
    @user = User.find(params[:id])
  end
end
