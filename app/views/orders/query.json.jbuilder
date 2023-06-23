json.array!(@orders) do |order|
  json.extract! order, :id,:payment, :table_id,:notas,:colonia,:numero_interior,:numero_exterior,:calle,:telefono,:nombre
  json.table_name order.table.name unless  order.table.nil?
  json.url order_url(order)
  json.pedidos order.pedidos
  json.total order.total
  json.descuentoTotal order.descuentoTotal
  json.a_domicilio order.takeaway
  json.platillos  (order.saucerOrders) do |so|
    json.notas so.notes
    json.id so.id
    json.discount so.discount
    json.name so.platillo.name unless so.platillo.nil?
    json.price so.price
    json.category_id so.platillo
    json.quantity so.quantity.to_s
    json.created_at so.created_at
    json.updated_at so.updated_at
    json.group_id so.platillo.group_id unless so.platillo.nil?
    json.is_child so.platillo.is_child unless so.platillo.nil?
  end
  json.user_type current_user.tipo unless current_user.nil?
  json.ver pay_path(order)
  json.finalizar paynow_path(order)
  json.imprimir order_path(order,:format => :pdf)
  json.mesero order.mesero unless order.mesero.nil?
  json.fecha (Order.last.created_at+8.hours).strftime("%d/%m/%Y")
  json.hora (Order.last.created_at+8.hours).strftime("%H:%M")
  json.cliente order.nombre if order.takeaway
  unless order.saucerOrders.first.nil?
    json.descuentoGeneral  order.saucerOrders.first.discount 
    json.iva_check (order.saucerOrders.first.iva > 0)
    json.iva_valor order.saucerOrders.first.iva
  else
    json.descuentoGeneral  0 
  end
  
end
