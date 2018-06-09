class AddSucRefToExpense < ActiveRecord::Migration
  def change
    add_reference :expenses, :sucursal, index: true, foreign_key: true
  end
end
