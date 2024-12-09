require "test_helper"

class ApiControllerTest < ActionDispatch::IntegrationTest
  test "should get rest" do
    get api_rest_url
    assert_response :success
  end
end
