class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @travelplan = @user.travelplans.last
  end
end
