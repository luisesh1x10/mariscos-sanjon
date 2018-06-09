class CreateInventarios < ActiveRecord::Migration
  def change
    create_table :inventarios do |t|
      t.references :sucursal, index: true, foreign_key: true
      t.references :ingrediente, index: true, foreign_key: true
      t.float :existencia

      t.timestamps null: false
    end
  end
end
