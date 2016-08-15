class AddTakeawayToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :takeaway, :boolean, :default => false
    add_reference :orders, :customer, index: true, foreign_key: true
  end
end
