class AddReferenceIngredientoToRequetsLine < ActiveRecord::Migration
  def change
    add_reference :requets_lines, :ingrediente, index: true, foreign_key: true
    add_reference :requets_lines, :requet, index: true, foreign_key: true
  end
end
