require 'test_helper'

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  
  include Devise::Test::IntegrationHelpers
  setup do
    get '/users/sign_in'
    sign_in users(:user_0001)
    post user_session_url
    @profile = profiles(:one)
  end

  test "should get index" do
    get profiles_url
    assert_response :success
  end

  test "should get new" do
    get new_profile_url
    assert_response :success
  end

  test "should create profile" do
    
    assert_difference('Profile.count') do
      post profiles_url, params: { profile: { name: 'Marcio', telephone: '111222333', user_id: '1'} }
    end

    assert_redirected_to profile_url(Profile.last)
  end

  test "should show profile" do
    get profile_url(@profile)
    assert_response :success
  end

  test "should get edit" do
    get edit_profile_url(@profile)
    assert_response :success
  end

  test "should update profile" do
    patch profile_url(@profile), params: { profile: { name: @profile.name, telephone: @profile.telephone, user_id: @profile.user_id } }
    assert_redirected_to profile_url(@profile)
  end

  test "should destroy profile" do
    assert_difference('Profile.count', -1) do
      allow_any_instance_of(ApplicationController).to receive(:set_current_user).and_return(fuser)

      delete profile_url(@profile)
    end

    assert_redirected_to profiles_url
  end
end
