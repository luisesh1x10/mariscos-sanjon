class CreateBags < ActiveRecord::Migration
  def change
    create_table :bags do |t|

      t.timestamps null: false
    end
  end
end
