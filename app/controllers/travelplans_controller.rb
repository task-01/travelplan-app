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
    @travelplan = Travelplan.new(content_params)
    @client = OpenAI::Client.new(access_token: ENV["CHATGPT_API_KEY"])
    question = "#{@travelplan.content_chat}の旅行プランを1日目 朝食~, 午前~, 昼食, 午後, 夕方, 夕食, 宿泊、
    2日目 朝食~, 午前~, 昼食, 午後, 夕方, 夕食, 宿泊, といった日付軸の形式で省略せずに全ての日数を1日つづ提案してください、
    また#{@travelplan.tourist_spot}が入力されている時はそれを1日だけ含んだ旅行プランを提案してください"
    response = @client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: question }],
        temperature: 0.3,
      }
    )
    @travelplan.gpt_response = response.dig('choices', 0, 'message', 'content')
    if @travelplan.save
      TravelplanUser.create(user: current_user, travelplan: @travelplan)
      redirect_to user_path(@travelplan.user_id)
    else
      render :new
    end
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
