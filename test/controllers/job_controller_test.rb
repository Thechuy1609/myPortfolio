require "test_helper"

class JobControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    user = users(:one)
    sign_in user
   get jobs_path(user)
   assert_response :success
  end
end
