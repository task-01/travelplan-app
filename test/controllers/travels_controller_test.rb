require "test_helper"

class TravelsControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get travels_home_url
    assert_response :success
  end
end
