class AddDatosServicioADomicilioToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :nombre, :string
    add_column :orders, :telefono, :string
    add_column :orders, :calle, :string
    add_column :orders, :numero_exterior, :string
    add_column :orders, :numero_interior, :string
    add_column :orders, :colonia, :string
    add_column :orders, :notas, :text
  end
end
