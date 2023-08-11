class TravelplansController < ApplicationController
  def home 
    @user = current_user
  end
  
  def new
    @user = current_user
  end
end
