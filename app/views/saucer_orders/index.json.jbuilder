json.array!(@saucer_orders) do |saucer_order|
  json.extract! saucer_order, :id
  json.url saucer_order_url(saucer_order, format: :json)
end
