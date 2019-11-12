class AddCantidadToRequetsLine < ActiveRecord::Migration
  def change
    add_column :requets_lines, :cantidad, :float
  end
end
