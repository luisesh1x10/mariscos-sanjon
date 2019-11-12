class CreateRequetsLines < ActiveRecord::Migration
  def change
    create_table :requets_lines do |t|

      t.timestamps null: false
    end
  end
end
