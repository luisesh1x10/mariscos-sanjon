class AddMapToPlatillo < ActiveRecord::Migration
  def change
    add_column :platillos, :map, :file
  end
end
