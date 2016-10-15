class AddStatusToBag < ActiveRecord::Migration
  def change
    add_column :bags, :status, :integer
  end
end
