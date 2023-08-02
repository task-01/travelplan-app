class ApplicationController < ActionController::Base

  before_action :set_common_variable

  private

  def set_common_variable
    @client = OpenAI::Client.new(access_token: ENV["CHATGPT_API_KEY"])
  end
end
