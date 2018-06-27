class RemoveStrockToIngrediente < ActiveRecord::Migration
  def change
    remove_column :ingredientes, :stock, :float
  end
end
