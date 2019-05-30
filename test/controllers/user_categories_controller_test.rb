require 'test_helper'

class UserCategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_categories_index_url
    assert_response :success
  end

  test "should get show" do
    get user_categories_show_url
    assert_response :success
  end

  test "should get create" do
    get user_categories_create_url
    assert_response :success
  end

  test "should get destroy" do
    get user_categories_destroy_url
    assert_response :success
  end

end
