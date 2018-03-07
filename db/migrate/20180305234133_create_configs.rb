class CreateConfigs < ActiveRecord::Migration
  def change
    create_table :configs do |t|
      t.integer :iva

      t.timestamps null: false
    end
  end
end
