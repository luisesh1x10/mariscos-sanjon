class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :nombre
      t.references :measurement_unit, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
