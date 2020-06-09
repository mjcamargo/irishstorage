class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.string :dropoffdate
      t.string :dropofftime
      t.string :pickupdate
      t.string :pickuptime
      t.integer :numluggage
      t.decimal :total
      t.references :shop, foreign_key: true

      t.timestamps
    end
  end
end
