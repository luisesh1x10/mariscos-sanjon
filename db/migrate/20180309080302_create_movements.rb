class CreateMovements < ActiveRecord::Migration
  def change
    create_table :movements do |t|
      t.integer :tipo
      t.decimal :cantidad , :precision => 15, :scale => 2
      t.references :user, index: true, foreign_key: true
      t.string :descripcion

      t.timestamps null: false
    end
  end
end
