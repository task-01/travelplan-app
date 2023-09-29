RSpec.describe 'Users', type: :system do
  let(:user) { create(:user) }
  let(:other_user1) { create(:user) }
  let(:other_user2) { create(:user) }
  let(:travelplan) { create(:travelplan) }
  let!(:travelplan_user) { create(:travelplan_user, travelplan: travelplan, user: user) }
  let!(:like) { create(:like, user: user, travelplan: travelplan) }
  let!(:active_follows) { create(:follow, follower: user, followed: other_user1) }
  let!(:passive_follows) { create(:follow, follower: other_user2, followed: user) }

  describe '#show' do
    before do
      sign_in user
      visit user_path(user.id)
    end

    it 'ユーザー情報を取得できること' do
      within '.show-mypage' do
        expect(page).to have_content(user.name)
        expect(page).to have_css("img[src*='https://potepanecportfolio.s3.ap-northeast-1.amazonaws.com/user_image/user_image.png']")
      end
    end

    it 'プロフィール編集を押すとモーダルウィンドウが出現すること' do
      within '.user-section' do
        click_on 'プロフィール編集'
      end
      expect(page).to have_css('.modal-content')
    end

    it 'いいね履歴を取得できること' do
      liked_travelplan = user.liked_travelplans.first
      within first('.travelplan_prefecture_name') do
        expect(page).to have_content(liked_travelplan.prefecture_name)
      end
    end

    it '旅行プラン作成履歴を取得できること' do
      within first('.history_prefecture') do
        history_travelplan = user.travelplans.order(created_at: :desc)
        expect(page).to have_content(history_travelplan.first.prefecture_name)
      end
    end

    it 'ヘッダーのTravel Plan Appを選択するとホーム画面に遷移すること' do
      click_on 'Travel Plan App'
      expect(current_path).to eq home_travelplan_path(user.id)
    end

    it 'ヘッダーのTravel Plan Appを選択するとホーム画面に遷移すること' do
      click_on 'Travel Plan App'
      expect(current_path).to eq home_travelplan_path(user.id)
    end

    it 'ユーザーが他のユーザーをフォローできるか、また、ユーザーがフォロー解除できることを確認' do
      user_count = user.active_follows.size
      other_count = other_user2.passive_follows.size
      visit list_users_path
      find("a[href='/follows?user_id=#{other_user2.id}']").click
      expect(user.active_follows.size).to eq user_count + 1
      expect(other_user2.reload.passive_follows.size).to eq other_count + 1
      find("a[href='/follows/#{other_user2.id}']").click
      expect(user.active_follows.size).to eq user_count
      expect(other_user2.passive_follows.size).to eq other_count
    end

    it 'ゲストユーザーでログインでききること' do
      sign_out user
      visit '/'
      click_on('ゲストログイン（閲覧用）')
      within '.dropdown-toggle' do
        expect(page).to have_content('ゲスト')
      end
    end
  end
end
