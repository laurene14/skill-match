require "test_helper"

class UserProfile::ProfileControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get user_profile_profile_show_url
    assert_response :success
  end
end
