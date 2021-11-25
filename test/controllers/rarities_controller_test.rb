require "test_helper"

class RaritiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get rarities_index_url
    assert_response :success
  end

  test "should get show" do
    get rarities_show_url
    assert_response :success
  end
end
