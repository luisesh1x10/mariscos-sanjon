class AddCajeroReferencesToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :cajero_id, :integer
  end
end
