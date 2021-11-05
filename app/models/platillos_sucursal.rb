class PlatillosSucursal < ActiveRecord::Base
  belongs_to :platillo
  belongs_to :sucursal
end
