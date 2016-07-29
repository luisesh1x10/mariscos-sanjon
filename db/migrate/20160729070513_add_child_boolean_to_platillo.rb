class AddChildBooleanToPlatillo < ActiveRecord::Migration
  def change
    add_column :platillos, :is_child, :boolean
  end
end
