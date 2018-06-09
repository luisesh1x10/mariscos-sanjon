class AddRefereceIngredienteToExpense < ActiveRecord::Migration
  def change
    add_reference :expenses, :ingrediente, index: true, foreign_key: true
  end
end
