class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :nombre
      t.integer :telefono
      t.string :calle
      t.string :colonia
      t.integer :numero_interior
      t.integer :numero_exterior

      t.timestamps null: false
    end
  end
end
