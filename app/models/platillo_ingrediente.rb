class PlatilloIngrediente < ActiveRecord::Base
	 belongs_to :platillo, dependent: :destroy
  	 belongs_to :ingredient, dependent: :destroy
end
