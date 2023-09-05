class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @travelplan = Travelplan.find(params[:id])
    current_user.likes.create(travelplan: @travelplan)
    respond_to do |format|
      format.html { redirect_to @travelplan }
      format.js
    end
  end

  def destroy
    @travelplan = Travelplan.find(params[:id])
    current_user.likes.find_by(travelplan_id: @travelplan.id).destroy
    respond_to do |format|
      format.html { redirect_to @travelplan }
      format.js
    end
  end
  
  private

  def authenticate_user!
    if !user_signed_in?
      flash[:alert] = "アカウント登録もしくはログインしてください。"
      redirect_to new_user_session_path
    end
  end
end


