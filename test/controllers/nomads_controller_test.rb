require "test_helper"

class NomadsControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get nomads_top_url
    assert_response :success
  end
end
