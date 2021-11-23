require "test_helper"

class CardsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get cards_index_url
    assert_response :success
  end

  test "should get view" do
    get cards_view_url
    assert_response :success
  end
end
