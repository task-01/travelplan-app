class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      flash[:alert] = "ユーザーが見つかりませんでした。"
      redirect_to root_path
      return
    end
    @travelplan = @user.travelplans.order(created_at: :desc).first
    @travelplans = @user.travelplans.order(created_at: :desc)
    respond_to do |format|
      format.html
      format.json do
        render json: {
          user: @user, job_status: @travelplan&.job_status,
          user_job_status: @user.job_status,
        }
      end
    end
  end

  def travelplan_pdf
    @user = User.find(params[:id])
    @travelplan = @user.travelplans.order(created_at: :desc).first
    respond_to do |format|
      format.pdf do
        pdf_html = render_to_string('shared/_set_travel.html.erb',
          layout: 'pdf.html.erb',
          locals: { travelplan: @travelplan })
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

  def acount
    @user = current_user
  end

  def list
    @user = current_user
    users = User.all.includes(:travelplans)
    if params[:name].present?
      users = users.where("name LIKE ?", "%#{params[:name]}%")
    end

    case params[:sort_order]
    when 'newest'
      users = users.order(created_at: :desc)
    when 'follow'
      users = users.left_joins(:active_follows).group(:id).order('COUNT(follows.follower_id) DESC')
    when 'followers'
      users = users.left_joins(:passive_follows).group(:id).order('COUNT(follows.followed_id) DESC')
    end
    @users = users
    @user_count = User.count
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "#{@user.name}が情報を更新しました"
      sign_in :user, @user, bypass: true
      redirect_to user_path(@user.id)
    else
      render "acount"
    end
  end

  def update_job_status
    @user = User.find(params[:id])
    @user.update(job_status: "completed")
    render json: { status: "success" }
  end

  private

  def user_params
    params.require(:user).permit(:image, :name, :email, :password, :password_confirmation)
  end
end
