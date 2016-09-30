class AddPaymentToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :payment, :float
  end
end
