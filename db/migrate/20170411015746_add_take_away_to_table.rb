class AddTakeAwayToTable < ActiveRecord::Migration
  def change
    add_column :tables, :take_away, :boolean
  end
end
