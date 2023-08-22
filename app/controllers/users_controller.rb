class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @travelplan = @user.travelplans.last
    @travelplans = @user.travelplans.includes(:users)
    respond_to do |format|
      format.html
      format.json { render json: { user: @user, job_status: @travelplan&.job_status }  }
    end
  end
end
