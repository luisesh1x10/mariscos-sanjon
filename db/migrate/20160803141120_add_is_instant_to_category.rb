class AddIsInstantToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :is_instant, :boolean
  end
end
