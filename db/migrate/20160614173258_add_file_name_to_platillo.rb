class AddFileNameToPlatillo < ActiveRecord::Migration
  def change
    add_column :platillos, :file_name, :string
  end
end
