require 'test_helper'

class Tenant::ScreeningRoomControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tenant_screening_room_index_url
    assert_response :success
  end

end
