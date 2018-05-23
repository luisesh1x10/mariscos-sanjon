ActiveAdmin.register Table do
menu label: "Mesas"

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

permit_params :description, :name,:take_away,:sucursal_id
  form do |f|
    inputs 'Details' do
      input :description, label:"Descripcion"
      input :name, label:"Nombre de mesa"
      f.input :sucursal , :collection => Sucursal.all.map{ |suc| [suc.nombre, suc.id] }
      input :take_away, label: "Para llevar"
      actions
    end
  end
end
