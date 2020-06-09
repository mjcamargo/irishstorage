require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  
  setup do
    get '/users/sign_in'
    sign_in users(:user_0001)
    post user_session_url
  end
  
  test "should get index" do
    get home_index_url
    assert_response :success
  end

end
