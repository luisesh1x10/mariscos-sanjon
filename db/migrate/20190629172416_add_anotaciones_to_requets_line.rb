class AddAnotacionesToRequetsLine < ActiveRecord::Migration
  def change
    add_column :requets_lines, :anotaciones, :string
  end
end
