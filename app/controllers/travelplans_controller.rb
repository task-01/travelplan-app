class TravelplansController < ApplicationController
  def home
    @user = current_user
  end

  def new
    @user = current_user
    @prefecture_names = [
      "北海道", "青森県", "岩手県", "宮城県", "秋田県", "山形県", "福島県",
      "茨城県", "栃木県", "群馬県", "埼玉県", "千葉県", "東京都", "神奈川県",
      "新潟県", "富山県", "石川県", "福井県", "山梨県", "長野県", "岐阜県", "静岡県",
      "愛知県", "三重県", "滋賀県", "京都府", "大阪府", "兵庫県", "奈良県", "和歌山県",
      "鳥取県", "島根県", "岡山県", "広島県", "山口県", "徳島県", "香川県", "愛媛県",
      "高知県", "福岡県", "佐賀県", "長崎県", "熊本県", "大分県", "宮崎県", "鹿児島県", "沖縄県",
    ]
    @number_days = ["1日", "2日間", "3日間", "4日間", "5日間", "6日間", "7日間"]
    @travelplan = Travelplan.new
  end

  def create
    TravelplanCreationJob.perform_later(content_params, current_user.id)

    redirect_to user_path(current_user.id)
  end

  def show
    @user = User.find_by(params[:travelplan][:user_id])
    @travelplan = Travelplan.find(params[:id])
  end

  private

  def content_params
    params.require(:travelplan).permit(:gpt_response, :travelplan_name, :prefecture_name,
:tourist_spot, :number_day, :content_chat, :user_id, :end_date, :start_date)
  end
end
