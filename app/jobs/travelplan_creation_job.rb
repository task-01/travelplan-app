class TravelplanCreationJob < ApplicationJob
  queue_as :default

  def perform(travelplan_id, user_id)
    Rails.logger.info "TravelplanCreationJobが開始されました。travelplan_id: #{travelplan_id}, user_id: #{user_id}"
    travelplan = Travelplan.find_by(id: travelplan_id)
    Rails.logger.info "#{travelplan}"
    travelplan.gpt_response = travelplan.fetch_gpt_response
    if travelplan.save
      travelplan.update(job_status: "completed")
      TravelplanUser.create(user_id: user_id, travelplan: travelplan)
    else
      Rails.logger.error "#{travelplan_id}を使用して旅行プランを保存できませんでした"
    end
  end
end
