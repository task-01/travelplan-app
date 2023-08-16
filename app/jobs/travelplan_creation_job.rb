class TravelplanCreationJob < ApplicationJob
  queue_as :default

  def perform(content_params, user_id)
    @travelplan = Travelplan.new(content_params)
    @travelplan.gpt_response = @travelplan.fetch_gpt_response

    if @travelplan.save
      TravelplanUser.create(user_id: user_id, travelplan_id: @travelplan.id)
    end
  end
end
