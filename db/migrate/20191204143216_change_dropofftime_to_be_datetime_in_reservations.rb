class ChangeDropofftimeToBeDatetimeInReservations < ActiveRecord::Migration[5.2]
  def change
    change_column :reservations, :dropofftime, :datetime
  end
end
