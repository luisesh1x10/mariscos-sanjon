class AddTakeawayToSaucerOrder < ActiveRecord::Migration
  def change
    add_column :saucer_orders, :takeaway, :boolean, :default => false
  end
end
