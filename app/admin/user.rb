ActiveAdmin.register User do

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
end
