class Platillo < ActiveRecord::Base
  belongs_to :category
  has_many :ingredients
  has_many :platillo_ingrediente, :through => :ingredients
  accepts_nested_attributes_for :ingredients, allow_destroy: true
end
