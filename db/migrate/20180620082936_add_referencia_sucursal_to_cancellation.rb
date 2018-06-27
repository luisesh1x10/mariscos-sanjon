class AddReferenciaSucursalToCancellation < ActiveRecord::Migration
  def change
    add_reference :cancellations, :sucursal, index: true, foreign_key: true
  end
end
