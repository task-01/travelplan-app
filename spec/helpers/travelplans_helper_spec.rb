RSpec.describe 'TravelplansHelper', type: :helper do
  describe 'prefecture_to_english' do
    it '都道府県名が英語に変換されていること' do
      expect(helper.prefecture_to_english('北海道')).to eq 'hokkaido'
    end

    it '存在しない都道府県名の場合、そのまま返すこと' do
      expect(helper.prefecture_to_english('存在しない県')).to eq '存在しない県'
    end
  end
end
