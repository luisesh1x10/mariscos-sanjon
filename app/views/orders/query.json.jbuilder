json.array!(@orders) do |order|
  json.extract! order, :id,:payment, :table_id
  json.url order_url(order)
  json.pedidos order.pedidos
  json.total order.total
  json.platillos order.platillos
  json.user_type current_user.tipo
  json.ver pay_path(order)
  json.finalizar paynow_path(order)
  json.imprimir order_path(order,:format => :pdf)
  json.mesero order.mesero
  json.fecha (Order.last.created_at+6.hours).strftime("%d/%m/%Y")
  json.hora (Order.last.created_at+6.hours).strftime("%H:%M")
  json.cliente order.customer.nombre if order.takeaway
end
