ActiveAdmin.register User do
    remove_filter :saucer_orders
    filter :sucursal, collection: -> {
        Sucursal.all.map { |suc| [suc.nombre, suc.id] }
    }
    filter :cedi, collection: -> {
        Cedi.all.map { |suc| [suc.nombre, suc.id] }
    }
    
    menu label: "Usuarios"
    index do 
        column :email
        column :tipo
        column :sucursal_id
        column :cedi_id
        actions
    end
permit_params :email, :password,:tipo,:name,:sucursal_id, :cedi_id
 form do |f|
    inputs 'Details' do
      input :name, label:"Nombre del empleado"
      input :email
      f.input :sucursal , :collection => Sucursal.all.map{ |suc| [suc.nombre, suc.id] }
      f.input :cedi , :collection => Cedi.all.map{ |ced| [ced.nombre, ced.id] }
      input :password, label: "Contraseña"
      f.input :tipo, :label => 'Tipo', :as => :select, :collection => [['Cocina',1],['mesero',2],['Caja',3],['Cedis',4]]
      li "Created at #{f.object.created_at}" unless f.object.new_record?
      actions
    end
  end
   controller do
    def update
      if params[:user][:password].blank?
        params[:user].delete("password")
        params[:user].delete("password_confirmation")
      end
      super
    end
  end
end
