require "test_helper"

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get :index" do
    get admin_:index_url
    assert_response :success
  end
end
