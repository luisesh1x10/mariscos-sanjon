ActiveAdmin.register SaucerOrder do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
menu label: "Historial de pedidos"
filter :sucursal, collection: -> {
    Sucursal.all.map { |suc| [suc.nombre, suc.id] }
}
filter :user, collection: -> {
    User.all.map { |suc| [suc.name, suc.id] }
}
filter :order_id
filter :discount
filter :iva
filter :price
filter :quantity
filter :created_at
filter :updated_at

index do
    column :order_id
    column "Sucursal", :sucursal_id do |ing|
        link_to ing.sucursal.nombre, admin_sucursal_path(ing.sucursal.id)
      end
    column "Mesero", :user_id do |ing|
        link_to ing.user.name, admin_user_path(ing.user) unless ing.user.nil?
      end
    column "Cajero", :user_id do |ing|
        link_to ing.order.cajero.name, admin_user_path(ing.order.cajero) unless ing.order.nil? or ing.order.cajero.nil?
      end
    column "Platillo", :platillo_id do |ing|
        link_to ing.platillo.name, admin_platillo_path(ing.platillo)
    end
    column :price
    column :quantity
    column "Total", :platillo_id do |ing|
        ing.quantity * ing.price
    end
    column :discount
    column :notes
    column :takeaway
    column :created_at
    column :updated_at
end
end
 