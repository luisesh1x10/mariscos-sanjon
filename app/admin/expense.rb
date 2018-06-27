ActiveAdmin.register Expense do

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
menu label: "Gastos"

    permit_params :category, :amount, :description, :quantity, :sucursal_id
    
    form do |f|
    inputs 'Details' do
      input :amount, label:"Costo"
      input :description, label: "Descripcion"
      input :quantity, label: "Cantidad de producto"
      f.input :sucursal , :collection => Sucursal.all.map{ |suc| [suc.nombre, suc.id] }
      f.input :category , :as => :select, :collection => [["Proveedores","1"], ["Servicios","2"], ["Nomina","4"],["Otros","3"]]
      
      actions
    end
  end

end
