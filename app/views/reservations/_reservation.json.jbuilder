json.extract! reservation, :id, :dropoffdate, :dropofftime, :pickupdate, :pickuptime, :numluggage, :total, :shop_id, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
