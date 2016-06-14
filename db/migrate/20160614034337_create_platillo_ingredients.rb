class CreatePlatilloIngredients < ActiveRecord::Migration
  def change
    create_table :platillo_ingredients do |t|
      t.references :platillo, index: true, foreign_key: true
      t.references :ingredient, index: true, foreign_key: true
      t.float :cantidad

      t.timestamps null: false
    end
  end
end
