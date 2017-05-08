json.array!(@bags) do |bag|
      json.extract! bag, :id,:status
      json.nombre_categoria @category.name
      json.is_instant @category.is_instant
      json.hora (bag.created_at+6.hours).strftime('%H:%M')
      json.avanzar avanzar_path(bag)
      json.platillos(bag.saucer_orders) do |pedido|
        json.extract! pedido, :id,:quantity,:notes
        json.takeaway pedido.order.takeaway
        json.table_name pedido.order.table.name unless pedido.order.table.nil?
        json.info pedido.platillo
      end
end