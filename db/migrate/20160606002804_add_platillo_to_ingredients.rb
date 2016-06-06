class AddPlatilloToIngredients < ActiveRecord::Migration
  def change
    add_reference :ingredients, :platillo, index: true, foreign_key: true
  end
end
