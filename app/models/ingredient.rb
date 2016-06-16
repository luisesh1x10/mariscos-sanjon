class Ingredient < ActiveRecord::Base
  belongs_to :measurement_unit
  belongs_to :platillo
  has_many :platillo_ingrediente
  accepts_nested_attributes_for :platillo, allow_destroy: true
  
  
end
