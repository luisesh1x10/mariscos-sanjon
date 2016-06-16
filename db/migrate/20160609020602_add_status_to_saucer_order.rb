class AddStatusToSaucerOrder < ActiveRecord::Migration
  def change
    add_column :saucer_orders, :status, :integer
  end
end
