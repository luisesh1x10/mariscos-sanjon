class AddSucRefToSaucerOrder < ActiveRecord::Migration
  def change
    add_reference :saucer_orders, :sucursal, index: true, foreign_key: true
  end
end
