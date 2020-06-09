class AddProfileToReservations < ActiveRecord::Migration[5.2]
  def change
    add_reference :reservations, :profile, foreign_key: true
  end
end
