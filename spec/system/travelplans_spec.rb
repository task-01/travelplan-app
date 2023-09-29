RSpec.describe 'Travelplans', type: :system do
  let(:user) { create(:user) }
  let(:travelplan) { create(:travelplan) }
  let(:travelplan2) { create(:travelplan, created_at: Time.current - 1.hour) }
  let!(:travelplan_user) { create(:travelplan_user, travelplan: travelplan, user: user) }

  describe '#index' do
    before do
      sign_in user
      visit travelplans_path
    end

    it '旅行プラン一覧を取得できること' do
      within first('.travelplan_prefecture_name') do
        expect(page).to have_content(travelplan.prefecture_name)
      end
    end

    it '新しい順を選択すると指定した並びに変化すること' do
      within('.sort_filter_area') do
        click_on('新しい順', match: :first)
        expect(travelplan.created_at).to be > travelplan2.created_at
      end
    end

    it '新しい順を選択すると指定した並びに変化すること' do
      select '東京都', from: 'q_prefecture_name_eq'
      click_on('絞り込み', match: :first)
      within('.travelplan_prefecture_name') do
        expect(page).not_to have_content('北海道')
      end
    end

    it 'PDFでダウンロードをクリックするとPDFがダウンロードできること' do
      click_on('PDFでダウンロード', match: :first)
      expect(page.response_headers['Content-Disposition']).to include('travel_plan.pdf')
      expect(page.response_headers['Content-Type']).to eq('application/pdf')
    end
  end
end
