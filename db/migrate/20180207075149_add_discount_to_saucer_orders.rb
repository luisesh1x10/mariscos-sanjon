class AddDiscountToSaucerOrders < ActiveRecord::Migration
  def change
    add_column :saucer_orders, :discount, :float, default: 0
  end
end
