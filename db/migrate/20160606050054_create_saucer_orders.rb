class CreateSaucerOrders < ActiveRecord::Migration
  def change
    create_table :saucer_orders do |t|
      t.references :platillo, index: true, foreign_key: true
      t.references :order, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
