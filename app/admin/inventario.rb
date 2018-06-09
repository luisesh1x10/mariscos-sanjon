ActiveAdmin.register Inventario do

 permit_params :sucursal_id, :ingrediente_id, :existencia,:minimo

  filter :sucursal, collection: -> {
        Sucursal.all.map { |suc| [suc.nombre, suc.id] }
    }
    filter :ingrediente, collection: -> {
        Ingrediente.all.map { |suc| [suc.nombre, suc.id] }
    }
    filter :existencia
    filter :minimo
    
    
    index do
      id_column
      column "Ingrediente", :ingrediente_id do |ing|
        link_to ing.ingrediente.nombre, admin_ingrediente_path(ing.ingrediente.id)
      end
      column :existencia
      column :minimo
      column "Sucursal", :sucursal_id do |ing|
        link_to ing.sucursal.nombre, admin_ingrediente_path(ing.sucursal.id)
      end
      actions
    end

    
    
    form do |f|
        f.semantic_errors *f.object.errors.keys
        f.inputs "Campos obligatiorios" do  
          f.inputs "" do
            f.input :sucursal , :collection => Sucursal.all.map{ |car| [car.nombre, car.id] }
            f.input :ingrediente , :collection => Ingrediente.all.map{ |car| [car.nombre, car.id] }
            f.input :existencia
            f.input :minimo
            
          end
      end
        f.actions
    end
end
