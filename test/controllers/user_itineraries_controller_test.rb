require 'test_helper'

class UserItinerariesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_itineraries_index_url
    assert_response :success
  end

  test "should get show" do
    get user_itineraries_show_url
    assert_response :success
  end

  test "should get create" do
    get user_itineraries_create_url
    assert_response :success
  end

  test "should get new" do
    get user_itineraries_new_url
    assert_response :success
  end

  test "should get edit" do
    get user_itineraries_edit_url
    assert_response :success
  end

  test "should get update" do
    get user_itineraries_update_url
    assert_response :success
  end

  test "should get destroy" do
    get user_itineraries_destroy_url
    assert_response :success
  end

end
