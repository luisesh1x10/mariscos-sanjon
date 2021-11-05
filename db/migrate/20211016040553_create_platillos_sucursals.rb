class CreatePlatillosSucursals < ActiveRecord::Migration
  def change
    create_table :platillos_sucursals do |t|
      t.references :platillo, index: true, foreign_key: true
      t.references :sucursal, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
