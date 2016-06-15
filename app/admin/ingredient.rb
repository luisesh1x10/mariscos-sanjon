ActiveAdmin.register Ingredient do

   menu false
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
index do
  column :name
  column :stock
  column :measurement_unit
  actions
end
 permit_params :name,:stock, :measurement_unit
 form do |f|
    f.inputs do
      input :name
      input :stock
      f.input :measurement_unit, :collection => MeasurementUnit.all.map{ |car| [car.name, car.id] }
    end
    actions
  end
end
