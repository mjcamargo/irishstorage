require "application_system_test_case"

class ReservationsTest < ApplicationSystemTestCase
  setup do
    @reservation = reservations(:one)
  end

  test "visiting the index" do
    visit reservations_url
    assert_selector "h1", text: "Reservations"
  end

  test "creating a Reservation" do
    visit reservations_url
    click_on "New Reservation"

    fill_in "Dropoffdate", with: @reservation.dropoffdate
    fill_in "Dropofftime", with: @reservation.dropofftime
    fill_in "Numluggage", with: @reservation.numluggage
    fill_in "Pickupdate", with: @reservation.pickupdate
    fill_in "Pickuptime", with: @reservation.pickuptime
    fill_in "Shop", with: @reservation.shop_id
    check "Total" if @reservation.total
    click_on "Create Reservation"

    assert_text "Reservation was successfully created"
    click_on "Back"
  end

  test "updating a Reservation" do
    visit reservations_url
    click_on "Edit", match: :first

    fill_in "Dropoffdate", with: @reservation.dropoffdate
    fill_in "Dropofftime", with: @reservation.dropofftime
    fill_in "Numluggage", with: @reservation.numluggage
    fill_in "Pickupdate", with: @reservation.pickupdate
    fill_in "Pickuptime", with: @reservation.pickuptime
    fill_in "Shop", with: @reservation.shop_id
    check "Total" if @reservation.total
    click_on "Update Reservation"

    assert_text "Reservation was successfully updated"
    click_on "Back"
  end

  test "destroying a Reservation" do
    visit reservations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Reservation was successfully destroyed"
  end
end
