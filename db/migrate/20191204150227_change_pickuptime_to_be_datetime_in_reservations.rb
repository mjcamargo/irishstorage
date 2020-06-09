class ChangePickuptimeToBeDatetimeInReservations < ActiveRecord::Migration[5.2]
  def change
    change_column :reservations, :pickuptime, :datetime
  end
end
