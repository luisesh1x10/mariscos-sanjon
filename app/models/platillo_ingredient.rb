class PlatilloIngredient < ActiveRecord::Base
  belongs_to :platillo
  belongs_to :ingredient
end
