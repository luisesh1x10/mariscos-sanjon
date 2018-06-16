class Ingredient < ActiveRecord::Base
  belongs_to :measurement_unit
  belongs_to :platillo
  has_many :platillo_ingrediente
  belongs_to :ingrediente
  accepts_nested_attributes_for :platillo, allow_destroy: true
  
  validates :ingrediente_id, :platillo_id, :stock, presence:true
end
