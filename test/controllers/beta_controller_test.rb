require "test_helper"

class BetaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get beta_index_url
    assert_response :success
  end
end
