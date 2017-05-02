json.array!(@orders) do |order|
  json.extract! order, :id,:payment, :table_id,:notas,:colonia,:numero_interior,:numero_exterior,:calle,:telefono,:nombre
  json.table_name order.table.name
  json.url order_url(order)
  json.pedidos order.pedidos
  json.total order.total
  json.a_domicilio order.takeaway
  json.platillos  (order.saucerOrders) do |so|
    json.id so.id
    json.name so.platillo.name unless so.platillo.nil?
    json.price so.price
    json.category_id so.platillo
    json.quantity so.quantity.to_s
    json.created_at so.created_at
    json.updated_at so.updated_at
    json.group_id so.platillo.group_id unless so.platillo.nil?
    json.is_child so.platillo.is_child unless so.platillo.nil?
  end
  json.user_type current_user.tipo
  json.ver pay_path(order)
  json.finalizar paynow_path(order)
  json.imprimir order_path(order,:format => :pdf)
  json.mesero order.mesero
  json.fecha (Order.last.created_at+6.hours).strftime("%d/%m/%Y")
  json.hora (Order.last.created_at+6.hours).strftime("%H:%M")
  json.cliente order.nombre if order.takeaway
end
