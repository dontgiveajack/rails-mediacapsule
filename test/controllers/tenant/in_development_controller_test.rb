require 'test_helper'

class Tenant::InDevelopmentControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tenant_in_development_index_url
    assert_response :success
  end

end
