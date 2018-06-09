class RemoveRefereceIngredientToExpense < ActiveRecord::Migration
  def change
    remove_reference :expenses, :ingredient, index: true, foreign_key: true
  end
end
