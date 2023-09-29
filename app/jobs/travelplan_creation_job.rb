class TravelplanCreationJob < ApplicationJob
  queue_as :default

  def perform(travelplan_id, user_id)
    travelplan = Travelplan.find(travelplan_id)
    travelplan.gpt_response = travelplan.fetch_gpt_response
    if travelplan.save
      travelplan.update(job_status: "completed")
      TravelplanUser.create(user_id: user_id, travelplan: travelplan)
    end
  end
end
