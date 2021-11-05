ActiveAdmin.register Category do
 
 menu label: "Categorias"
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
 permit_params :name,:is_instant, sucursal_ids:[]
  index do
    column :name
    actions
  end
  form do |f|
    f.inputs "nombre" do
      f.input :name, label: "Nombre"
    end
    f.inputs "Sucursales" do
      f.input :sucursal_ids, label: 'Sucursales*', as: :check_boxes, :collection => Sucursal.all.map{ |car| [car.nombre, car.id] }
    end
    f.actions
  end
end
