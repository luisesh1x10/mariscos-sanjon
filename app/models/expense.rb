class Expense < ActiveRecord::Base
    belongs_to :sucursal
    belongs_to :ingrediente
    belongs_to :user
    validates :category, :amount, :description, presence:true
    validates :amount, numericality: { greater_than_or_equal_to: 0 }
    after_create :guardar_inventario
    after_initialize :init
    def init
        self.quantity  ||= 0.0
        self.amount  ||= 0.0
        
    end
    
    def guardar_inventario
        unless self.ingrediente.nil?
            record = Inventario.where(sucursal_id:self.sucursal_id,ingrediente_id:self.ingrediente_id).last
            unless record.nil?
              record.update(existencia:record.existencia+self.quantity)
            end
        end
    end
end
