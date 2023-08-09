class TravelplansController < ApplicationController
  def home 
    @user = current_user
  end
end
