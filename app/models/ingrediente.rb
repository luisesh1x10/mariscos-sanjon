class Ingrediente < ActiveRecord::Base
  belongs_to :measurement_unit
  has_many :inventarios
  has_many :ingredients
  has_many :expenses
end
