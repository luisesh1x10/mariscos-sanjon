json.page @pagina
json.per_page @por_pagina
json.total_count @total_bags
json.total_pedidos @total_pedidos
json.has_more ((@pagina + 1) * @por_pagina) < @total_bags
json.bags(@bags) do |bag|
      json.extract! bag, :id,:status
      json.nombre_categoria @category.name
      json.is_instant @category.is_instant
      json.hora (bag.created_at+6.hours).strftime('%H:%M')
      json.inicio bag.created_at.iso8601
      json.avanzar avanzar_path(bag)
      json.mesero bag.saucer_orders.first.user.name
      json.platillos(bag.saucer_orders) do |pedido|
        json.extract! pedido, :id,:quantity,:notes
        json.takeaway pedido.order.takeaway
        json.table_name pedido.order.table.name unless pedido.order.table.nil?
        json.error pedido.id  if  pedido.order.table.nil?
        json.info pedido.platillo
      end
end
