class AddTipoToUser < ActiveRecord::Migration
  def change
    add_column :users, :tipo, :integer
  end
end
