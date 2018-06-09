class AddSucRefToBag < ActiveRecord::Migration
  def change
    add_reference :bags, :sucursal, index: true, foreign_key: true
  end
end
