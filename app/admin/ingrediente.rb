ActiveAdmin.register Ingrediente do

  menu priority: 2
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

	permit_params :nombre,:stock, :MeasurementUnit_id
	index do
	  column :nombre
	  column :stock
	  column :MeasurementUnit
	  actions

end
end
