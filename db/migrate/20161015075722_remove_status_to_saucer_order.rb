class RemoveStatusToSaucerOrder < ActiveRecord::Migration
  def change
    remove_column :saucer_orders, :status, :string
  end
end
