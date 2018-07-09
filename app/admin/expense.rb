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
  index do 
    column "Sucursal", :sucursal_id do |ing|
        link_to ing.sucursal.nombre, admin_sucursal_path(ing.sucursal.id)
      end
    column "usuario", :user_id do |ing|
        link_to ing.user.name, admin_user_path(ing.user) unless ing.user.nil?
      end
      column :category
      column :amount
      column :description
      column :quantity
      column "Ingrediente", :ingrediente_id do |ing|
        link_to ing.ingrediente.nombre, admin_ingrediente_path(ing.ingrediente) unless ing.ingrediente.nil?
      end
      column :created_at
  end

end
