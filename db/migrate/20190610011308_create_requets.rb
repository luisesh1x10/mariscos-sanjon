class CreateRequets < ActiveRecord::Migration
  def change
    create_table :requets do |t|
      t.references :sucursal, index: true, foreign_key: true
      t.integer :status
      t.string :anotaciones

      t.timestamps null: false
    end
  end
end
