# class TravelplanCreationJob < ApplicationJob
#   queue_as :default

#   def perform(travelplan, user_id, fetch_gpt_response)
#     user_travelplan = Travelplan.find_by(id: travelplan.id)
#     Rails.logger.info "#{travelplan.id}"
#     user_travelplan.gpt_response = fetch_gpt_response
#     if user_travelplan.save
#       user_travelplan.update(job_status: "completed")
#       TravelplanUser.create(user_id: user_id, travelplan: travelplan)
#     else
#       Rails.logger.error "#{travelplan_id}を使用して旅行プランを保存できませんでした"
#     end
#   end
# end
