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

	permit_params :nombre,:stock, :measurement_unit_id
	index do
	  column :nombre
	  column :stock
	  column :measurement_unit
	  actions

	end
	form do |f|
    f.semantic_errors *f.object.errors.keys
	    f.inputs "Unidad de medida" do
	      f.input :nombre
	      f.input :stock
	      f.input :measurement_unit_id,:as => :select, :collection => MeasurementUnit.all.map{ |car| [car.name, car.id] }
	    end
	    actions
    end
end
