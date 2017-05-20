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

permit_params :name,:cover,:price, :category_id,:map,:map_file_name,:group_id,:is_child ,:descripcion,
ingredients_attributes: [:id,:platillo_id,:name,:stock,:_destroy, :_create, :_update]

filter :name
filter :price
filter :category
filter :group



index do
  column :name, label: "Nombre"
  column :price 
  column :category
  column :group
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
      f.inputs "Ingredientes" do
        f.has_many :ingredients, heading: 'Ingrediente',new_record: true, allow_destroy: true do |s|
            s.input :name, :collection => Ingrediente.all.map{ |car| [car.nombre, car.id] }
            s.input :stock 
        end
      end
      f.inputs "Imagen" do
          f.input :cover, :as => :file
      end
    end
    f.actions
end
end
