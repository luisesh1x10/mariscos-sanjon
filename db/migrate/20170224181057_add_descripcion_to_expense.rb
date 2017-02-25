class AddDescripcionToExpense < ActiveRecord::Migration
  def change
    add_column :expenses, :description, :string
    add_reference :expenses, :ingredient, index: true, foreign_key: true
    add_column :expenses, :quantity, :integer
  end
end
