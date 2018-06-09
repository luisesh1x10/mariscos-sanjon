class AddReferenceIngredienteToIngredient < ActiveRecord::Migration
  def change
    add_reference :ingredients, :ingrediente, index: true, foreign_key: true
  end
end
