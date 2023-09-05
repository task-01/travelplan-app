class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @travelplan = @user.travelplans.order(created_at: :desc).first
    @travelplans = @user.travelplans.order(created_at: :desc)
    respond_to do |format|
        format.html
        format.json { render json: { user: @user, job_status: @travelplan&.job_status, user_job_status: @user.job_status } }
    end
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
      flash[:notice] = "ユーザーIDが「#{@user.id}」の情報を更新しました"
      redirect_to user_path(@user.id)
    else
      render "edit"
    end
  end

  def update_job_status
    @user = User.find(params[:id])
    @user.update(job_status: "completed")
    render json: { status: "success" }
  end
  
  private
  
  def user_params
    params.require(:user).permit(:image, :name)
  end
end
