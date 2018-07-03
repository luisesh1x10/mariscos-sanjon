class ChangeTipoStockToIngredient < ActiveRecord::Migration
  def change
      change_column :ingredients, :stock, :float
  end
end
