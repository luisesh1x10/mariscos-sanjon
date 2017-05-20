class AddDescripcionToPlatillos < ActiveRecord::Migration
  def change
    add_column :platillos, :descripcion, :text
  end
end
