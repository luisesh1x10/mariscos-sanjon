class AddTakeawayToSaucerOrder < ActiveRecord::Migration
  def change
    add_column :saucer_orders, :takeaway, :boolean
  end
end
