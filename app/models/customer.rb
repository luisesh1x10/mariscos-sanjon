class Customer < ActiveRecord::Base
  has_many :orders
  validates_uniqueness_of :telefono
  validates :nombre,
  :telefono,
  :calle,
  :colonia,
  :numero_exterior, presence:true
  def direccion  
    "colonia: #{colonia}, calle#{calle}, num_interior:#{numero_interior} num_exterior:#{numero_exterior}"
  end 
    
end
