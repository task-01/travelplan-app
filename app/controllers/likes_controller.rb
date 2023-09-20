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
    unless user_signed_in?
      flash[:alert] = "ログインもしくはアカウント登録してください。"
      respond_to do |format|
        format.html { redirect_to new_user_session_path }
        format.js { render js: 'window.location.replace("/users/sign_in");', status: 401 }
      end
    end
  end
end
