ActiveAdmin.register Cancellation do

    menu label: "Cancelaciones"

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
permit_params :platillo, :quantity, :justificacion, :sucursal_id, :user_id
filter :sucursal, collection: -> {
    Sucursal.all.map { |suc| [suc.nombre, suc.id] }
}
filter :user, collection: -> {
    User.all.map { |suc| [suc.nombre, suc.id] }
}

filter :justificacion
filter :platillo
filter :created_at
filter :updated_at
    

index do
  id_column
  column "Usuario", :user_id do |user|
    link_to user.user.name, admin_ingrediente_path(user.user.id)
  end
  column :platillo
  column :quantity
  column :justificacion
  column "Sucursal", :sucursal_id do |ing|
    link_to ing.sucursal.nombre, admin_ingrediente_path(ing.sucursal.id)
  end
  column :created_at
  actions
end


end
