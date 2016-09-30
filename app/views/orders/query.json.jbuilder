json.array!(@orders) do |order|
  json.extract! order, :id,:payment, :table_id
  json.url order_url(order, format: :json)
  json.pedidos order.pedidos
  json.total order.total
  json.platillos order.platillos
  json.user_type current_user.tipo
  json.ver pay_path(order)
  json.imprimir order_path(order,:format => :pdf)
  
end
