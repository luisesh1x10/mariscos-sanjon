class CreatePlatillos < ActiveRecord::Migration
  def change
    create_table :platillos do |t|
      t.string :name
      t.float :price
      t.references :category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
