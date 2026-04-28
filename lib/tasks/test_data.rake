namespace :test_data do
  desc "Crea N bolsas/pedidos de prueba para una categoria. Uso: rake test_data:crear_pedidos[category_id,cantidad,sucursal_id]"
  task :crear_pedidos, [:category_id, :cantidad, :sucursal_id] => :environment do |_, args|
    category_id = (args[:category_id] || 2).to_i
    cantidad = (args[:cantidad] || 1000).to_i
    sucursal = args[:sucursal_id] ? Sucursal.find(args[:sucursal_id]) : Sucursal.first

    raise "No hay sucursal disponible" if sucursal.nil?

    category = Category.find(category_id)
    platillos = Platillo.where(category_id: category_id).to_a
    raise "No hay platillos en la categoria #{category_id} ('#{category.name}')" if platillos.empty?

    user = User.where(sucursal_id: sucursal.id).first || User.first
    table = Table.where(sucursal_id: sucursal.id).first || Table.first
    raise "No hay usuario disponible" if user.nil?
    raise "No hay mesa disponible" if table.nil?

    # Evita que se descuente el inventario al crear saucer_orders de prueba
    SaucerOrder.skip_callback(:create, :after, :descontar_inventario)

    puts "Creando #{cantidad} pedidos de prueba en categoria '#{category.name}' (sucursal: #{sucursal.nombre})..."

    creados = 0
    ActiveRecord::Base.transaction do
      cantidad.times do |i|
        order = Order.create!(
          table_id: table.id,
          status: 1,
          takeaway: false,
          sucursal_id: sucursal.id,
          cajero_id: user.id
        )
        bag = Bag.create!(status: 1, sucursal_id: sucursal.id)
        platillo = platillos.sample
        SaucerOrder.create!(
          platillo_id: platillo.id,
          order_id: order.id,
          bag_id: bag.id,
          user_id: user.id,
          sucursal_id: sucursal.id,
          quantity: [1, 2, 3].sample,
          notes: "TEST-#{i + 1}",
          price: platillo.price || 0,
          takeaway: false,
          discount: 0,
          iva: 0
        )
        creados += 1
        if (creados % 50).zero?
          print "\r  #{creados}/#{cantidad}"
          STDOUT.flush
        end
      end
    end

    SaucerOrder.set_callback(:create, :after, :descontar_inventario)
    puts "\nListo. #{creados} pedidos creados."
  end

  desc "Elimina todos los pedidos de prueba (notes LIKE 'TEST-%')"
  task :borrar_pedidos => :environment do
    saucers = SaucerOrder.where("notes LIKE 'TEST-%'")
    order_ids = saucers.pluck(:order_id).uniq
    bag_ids = saucers.pluck(:bag_id).uniq
    count = saucers.count
    puts "Eliminando #{count} saucer_orders de prueba..."
    saucers.delete_all
    Order.where(id: order_ids).delete_all
    Bag.where(id: bag_ids).delete_all
    puts "Listo."
  end
end
