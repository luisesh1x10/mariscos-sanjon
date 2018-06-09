class Ingrediente < ActiveRecord::Base
  belongs_to :measurement_unit
  has_many :inventarios
  has_many :ingredients
  has_many :expenses
  after_create :agregar_a_inventarios
  
  def agregar_a_inventarios
    Sucursal.all.each do |s|
      Inventario.create(ingrediente_id:self.id,sucursal_id:s.id)
    end
  end
end
