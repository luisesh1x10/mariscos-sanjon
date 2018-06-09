class Inventario < ActiveRecord::Base
  belongs_to :sucursal
  belongs_to :ingrediente
  
  validates :sucursal_id , :ingrediente_id , :existencia , presence:true 
  validates_uniqueness_of :sucursal_id, scope: [:sucursal_id, :ingrediente_id]
  after_initialize :init
  def init
      self.minimo  ||= 0.0
      self.existencia  ||= 0.0
  end
end
