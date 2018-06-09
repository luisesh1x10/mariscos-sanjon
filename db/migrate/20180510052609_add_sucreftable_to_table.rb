class AddSucreftableToTable < ActiveRecord::Migration
  def change
    add_reference :tables, :sucursal, index: true, foreign_key: true
  end
end
