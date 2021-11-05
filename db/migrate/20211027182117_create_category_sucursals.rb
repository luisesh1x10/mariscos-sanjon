class CreateCategorySucursals < ActiveRecord::Migration
  def change
    create_table :category_sucursals do |t|
      t.references :category, index: true, foreign_key: true
      t.references :sucursal, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
