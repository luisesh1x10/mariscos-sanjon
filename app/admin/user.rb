ActiveAdmin.register User do
    index do
        column :email
        column :tipo
        actions
    end
permit_params :email, :password,:tipo
 form do |f|
    inputs 'Details' do
      input :email
      input :password, label: "Contraseña"
      f.input :tipo, :label => 'Tipo', :as => :select, :collection => [['Cocina',1],['mesero',2],['Caja',3]]
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
