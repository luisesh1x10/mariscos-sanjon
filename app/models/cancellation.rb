class Cancellation < ActiveRecord::Base
  belongs_to :user
  belongs_to :sucursal
  validates :sucursal_id , presence:true
    
    def self.init_sucursales
        Cancellation.all.each do |c|
            c.update(sucursal_id:c.user.sucursal_id)
        end
    end
    
end
