require 'test_helper'

class ReservationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    get '/users/sign_in'
    sign_in users(:user_0001)
    post user_session_url
    @profile = profiles(:one)
    @reservation = reservations(:one)
  end

  test "should get index" do
    get reservations_url
    assert_response :success
  end

  test "should get new" do
    get :new
    
    assert_response :success
    
  end

  test "should create reservation" do
    assert_difference('Reservation.count') do
      post reservations_url, params: { reservation: { dropoffdate: @reservation.dropoffdate, dropofftime: @reservation.dropofftime, numluggage: @reservation.numluggage, pickupdate: @reservation.pickupdate, pickuptime: @reservation.pickuptime, shop_id: @reservation.shop_id, total: @reservation.total } }
    end

    assert_redirected_to reservation_url(Reservation.last)
  end

  test "should show reservation" do
    get reservation_url(@reservation)
    assert_response :success
  end

  test "should get edit" do
    get edit_reservation_url(@reservation)
    assert_response :success
  end

  test "should update reservation" do
    patch reservation_url(@reservation), params: { reservation: { dropoffdate: @reservation.dropoffdate, dropofftime: @reservation.dropofftime, numluggage: @reservation.numluggage, pickupdate: @reservation.pickupdate, pickuptime: @reservation.pickuptime, shop_id: @reservation.shop_id, total: @reservation.total } }
    assert_redirected_to reservation_url(@reservation)
  end

  test "should destroy reservation" do
    assert_difference('Reservation.count', -1) do
      delete reservation_url(@reservation)
    end

    assert_redirected_to reservations_url
  end
end
