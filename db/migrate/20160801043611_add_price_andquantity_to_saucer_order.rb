class AddPriceAndquantityToSaucerOrder < ActiveRecord::Migration
  def change
    add_column :saucer_orders, :price, :float
    add_column :saucer_orders, :quantity, :integer
  end
end
