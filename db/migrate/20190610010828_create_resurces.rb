class CreateResurces < ActiveRecord::Migration
  def change
    create_table :resurces do |t|

      t.timestamps null: false
    end
  end
end
