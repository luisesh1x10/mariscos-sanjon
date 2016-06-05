class CreateSaucerOrders < ActiveRecord::Migration
  def change
    create_table :saucer_orders do |t|
      t.references :orders, index: true, foreign_key: true
      t.references :platillos, index: true, foreign_key: true
      t.string :annotations

      t.timestamps null: false
    end
  end
end
