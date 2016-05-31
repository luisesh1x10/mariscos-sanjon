class CreatePlatilloIngredientes < ActiveRecord::Migration
  def change
    create_table :platillo_ingredientes do |t|
      t.references :platillo, index: true, foreign_key: true
      t.references :ingredient, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
