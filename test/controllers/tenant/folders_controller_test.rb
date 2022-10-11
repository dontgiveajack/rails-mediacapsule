require 'test_helper'

class Tenant::FoldersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get tenant_folders_new_url
    assert_response :success
  end

  test "should get edit" do
    get tenant_folders_edit_url
    assert_response :success
  end

  test "should get create" do
    get tenant_folders_create_url
    assert_response :success
  end

  test "should get destroy" do
    get tenant_folders_destroy_url
    assert_response :success
  end

  test "should get update" do
    get tenant_folders_update_url
    assert_response :success
  end

end
