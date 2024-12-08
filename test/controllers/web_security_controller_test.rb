require "test_helper"

class WebSecurityControllerTest < ActionDispatch::IntegrationTest
  test "should get hash" do
    get web_security_hash_url
    assert_response :success
  end
end
