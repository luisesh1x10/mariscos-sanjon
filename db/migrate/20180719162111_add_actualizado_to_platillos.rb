class AddActualizadoToPlatillos < ActiveRecord::Migration
  def change
    add_column :platillos, :actualizado, :boolean, :default => false
  end
end
