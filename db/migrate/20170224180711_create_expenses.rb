class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.integer :category
      t.decimal :amount

      t.timestamps null: false
    end
  end
end
