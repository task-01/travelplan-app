class TravelplanCreationJob < ApplicationJob
  queue_as :default

  def perform(content_params, user_id)
    @travelplan = Travelplan.new(content_params)
    @client = OpenAI::Client.new(access_token: ENV["CHATGPT_API_KEY"])

    @travelplan.job_status = "in_progress"
    @travelplan.save
    @travelplan.gpt_response = @travelplan.fetch_gpt_response

    if @travelplan.save
      @travelplan.job_status = "completed"
      @travelplan.save
      TravelplanUser.create(user_id: user_id, travelplan: @travelplan)
    end
  end
end
