class TravelplansController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  PREFECTURE_NAMES = [
    "北海道", "青森県", "岩手県", "宮城県", "秋田県", "山形県", "福島県",
    "茨城県", "栃木県", "群馬県", "埼玉県", "千葉県", "東京都", "神奈川県",
    "新潟県", "富山県", "石川県", "福井県", "山梨県", "長野県", "岐阜県", "静岡県",
    "愛知県", "三重県", "滋賀県", "京都府", "大阪府", "兵庫県", "奈良県", "和歌山県",
    "鳥取県", "島根県", "岡山県", "広島県", "山口県", "徳島県", "香川県", "愛媛県",
    "高知県", "福岡県", "佐賀県", "長崎県", "熊本県", "大分県", "宮崎県", "鹿児島県", "沖縄県",
  ].freeze

  NUMBER_DAYS = ["1日", "2日間", "3日間", "4日間", "5日間"].freeze

  def home
    @user = current_user
    @travelplans = Travelplan.top_liked_prefecture(limit: 9)
    @prefecture_names = PREFECTURE_NAMES
  end

  def index
    @user = current_user
    @travelplan_count = Travelplan.count
    @q = Travelplan.ransack(params[:q])
    travelplans = @q.result.includes(:users, :likes, :likers).distinct
    case params[:sort_order]
    when 'newest'
      travelplans = travelplans.order(created_at: :desc)
    when 'oldest'
      travelplans = travelplans.order(created_at: :asc)
    when 'most_days'
      travelplans = travelplans.order(number_day: :desc)
    when 'least_days'
      travelplans = travelplans.order(number_day: :asc)
    when 'likes'
      travelplans = Travelplan.sorted_by_likes
    end
    @likes_counts = Like.group(:travelplan_id).size
    @travelplans = travelplans
    @prefecture_names = PREFECTURE_NAMES
    @number_days = NUMBER_DAYS
  end

  def travelplans_pdf
    travelplan = Travelplan.find(params[:id])
    respond_to do |format|
      format.pdf do
        pdf_html = render_to_string('shared/_travelplan_detail.html.erb',
          layout: 'pdf.html.erb',
          locals: { travelplan: travelplan })
        pdf = WickedPdf.new.pdf_from_string(
          pdf_html,
          stylesheets: false,
        )
        send_data pdf,
        filename: 'travel_plan.pdf',
        type: 'application/pdf',
        disposition: 'attachment'
      end
    end
  end

  def new
    @user = current_user
    @prefecture_names = PREFECTURE_NAMES
    @number_days = NUMBER_DAYS
    @travelplan = Travelplan.new
  end

  def create
    @travelplan = Travelplan.new(content_params.merge(job_status: "in_progress"))
    @travelplan.gpt_response = @travelplan.fetch_gpt_response
    if @travelplan.save
      current_user.update(job_status: "in_progress")
      flash[:notice] = "旅行プラン作成中ですこれには時間が掛かる場合があります..."
      redirect_to user_path(current_user)
    else
      flash[:alert] = "旅行プランの作成に失敗しました。再試行してください。"
      render :new
    end
  end

  def set_in_progress
    @travelplan = Travelplan.find(params[:id])
    @travelplan.job_status = "in_progress"
    if @travelplan.save
      render json: { status: 'success' }
    else
      render json: { status: 'error', message: @travelplan.errors.full_messages.join(", ") },
              status: :unprocessable_entity
    end
  end

  private

  def content_params
    params.require(:travelplan).permit(:gpt_response, :travelplan_name, :prefecture_name,
    :tourist_spot, :number_day, :content_chat, :end_date, :start_date, :user_id)
  end
end
