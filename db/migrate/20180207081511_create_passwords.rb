class CreatePasswords < ActiveRecord::Migration
  def change
    create_table :passwords do |t|
      t.string :pass

      t.timestamps null: false
    end
  end
end
