FactoryBot.define do
  factory :travelplan do
    travelplan_name { '東京旅行' }
    prefecture_name { '東京都' }
    job_status { 'completed' }
    number_day { '3日間' }
    content_chat { '3日間 東京' }
    gpt_response { '1日目\n観光スポット1\n観光スポット2\n2日目\n観光スポット3\n観光スポット4' }
    created_at { Time.current }
  end
end
