module IngredientsHelper

	def measurement_for_select
		MeasurementUnit.all.collect { |c| [c.name, c.id] }
	end
	
end
