class AddSucRefToOrder < ActiveRecord::Migration
  def change
    add_reference :orders, :sucursal, index: true, foreign_key: true
  end
end
