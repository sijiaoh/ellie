require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create :user
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user if accept terms of service" do
    assert_difference("User.count") do
      post users_url, params: { user: { terms_of_service: "1" } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should failed if not accept terms of service" do
    assert_no_difference("User.count") do
      post users_url, params: { user: { terms_of_service: "0" } }
    end
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end
end
