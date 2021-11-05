ActiveAdmin.register Platillo do

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
menu label: "Platillos"

permit_params :name,:cover,:price, :category_id,:map,:map_file_name,:group_id,:is_child ,:descripcion,:actualizado, sucursal_ids:[],
ingredients_attributes: [:id,:platillo_id,:name,:stock, :ingrediente_id,  :_destroy, :_create, :_update]
# platillosSucursals_attributes: [:id, :platillo_id, :sucursal_id, :nombre, :_destroy, :_create, :_update]

filter :name 
filter :price
filter :category
filter :group
filter :actualizado


index do
  column :name, label: "Nombre"
  column :price, label: "Precio" 
  column :category, label: "categoria"
  column :group, label: "grupo"
  actions
end

form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Campos obligatiorios" do  
      f.inputs "Platillo" do
        f.input :name
        f.input :price
        f.input :is_child ,label:"Para niño"
      end
      f.inputs "grupo" do
        f.input :group , :collection => Group.all.map{ |car| [car.name, car.id] }
      end
      f.inputs "Categoria" do
        f.input :category, :collection => Category.all.map{ |car| [car.name, car.id] }
      end
    end
    f.inputs "Campos opcionales" do
      f.inputs "Descripcion del platillo" do
        f.input :descripcion 
      end
      f.inputs "Sucursales" do
        f.input :sucursal_ids, label: 'Sucursales*', as: :check_boxes, :collection => Sucursal.all.map{ |car| [car.nombre, car.id] }
      end
      f.inputs "Ingredientes" do
        f.has_many :ingredients, heading: 'Ingrediente',new_record: true, allow_destroy: true do |s|
            s.input :ingrediente, :collection => Ingrediente.all.map{ |car| [car.nombre, car.id] }
            s.input :stock 
        end
      end

      # f.inputs "Sucursales" do
      #   f.has_many :platillosSucursals, heading: 'Sucursal',new_record: true, allow_destroy: true do |s|
      #       s.input :sucursal, :collection => Sucursal.all.map{ |car| [car.nombre, car.id] }
      #   end
      # end
      f.inputs "Marcar como actualizado si ya se agregaron los ingredientes conrrespondientes" do 
        
        f.input :actualizado
      end
      #f.inputs "Imagen" do
      #    f.input :cover, :as => :file
      #end
    end
    f.actions
end

  show do
    attributes_table do
      row :name
      row :price
      row :category
      row :group 
      
    end
    
    active_admin_comments
  end
  action_item :Siguente, only: :show do
  link_to 'Platillo sin Actualizar ->', "/admin/platillos/#{Platillo.where(actualizado:false).first.id}/edit?locale=es"
end
end
