class CreateInputs < ActiveRecord::Migration
  def change
    create_table :inputs do |t|
      t.references :resource, index: true, foreign_key: true
      t.float :cantidad
      t.float :precio

      t.timestamps null: false
    end
  end
end
