class CreateCancellations < ActiveRecord::Migration
  def change
    create_table :cancellations do |t|
      t.references :user, index: true, foreign_key: true
      t.string :justificacion
      t.string :platillo
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
