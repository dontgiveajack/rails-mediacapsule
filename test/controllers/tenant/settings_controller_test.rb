require 'test_helper'

class Tenant::SettingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tenant_settings_index_url
    assert_response :success
  end

end
