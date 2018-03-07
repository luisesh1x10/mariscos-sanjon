class AddIvaToSaucerOrders < ActiveRecord::Migration
  def change
    add_column :saucer_orders, :iva, :integer, :default => 0
  end
end
