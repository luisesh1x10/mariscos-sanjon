json.array!(@orders) do |order|
  json.extract! order, :id, :tables_id
  json.url order_url(order, format: :json)
end
