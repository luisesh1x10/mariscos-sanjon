json.extract! @order, :id,:payment, :table_id,:notas,:colonia,:numero_interior,:numero_exterior,:calle,:telefono,:nombre
json.url order_url( @order, format: :json)
json.pedidos @order.pedidos