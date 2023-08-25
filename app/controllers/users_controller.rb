class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @travelplan = @user.travelplans.last
    @travelplans = @user.travelplans.includes(:users).order(created_at: :desc)
    respond_to do |format|
      format.html
      format.json { render json: { user: @user, job_status: @travelplan&.job_status }  }
    end
  end
end
