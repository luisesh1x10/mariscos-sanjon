class AddSucurrefuserToUser < ActiveRecord::Migration
  def change
    add_reference :users, :sucursal, index: true, foreign_key: true
  end
end
