RSpec.describe 'Travelplan', type: :model do
  describe '#fetch_gpt_response' do
    let(:travelplan) { create(:travelplan, content_chat: '3日間 東京') }

    it 'GPT-3 API から応答を返ってくること' do
      response = travelplan.fetch_gpt_response
      expect(response).to include('Day 1：').or include('3日目：')
    end
  end
end
