class AddNotesToSaucerOrders < ActiveRecord::Migration
  def change
    add_column :saucer_orders, :notes, :string
  end
end
