class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    user_to_follow = User.find(params[:user_id])
    current_user.follow(user_to_follow)
    redirect_to request.referer
  end

  def destroy
    user_to_unfollow = User.find(params[:id])
    current_user.unfollow(user_to_unfollow)
    redirect_to request.referer  
  end

  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
end
