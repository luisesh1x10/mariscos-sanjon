json.extract! table, :id,:name,:description,:take_away
json.order_number table.orders.count
json.ordenes table.orders.where.not(status:2)