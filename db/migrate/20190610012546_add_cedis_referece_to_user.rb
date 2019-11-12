class AddCedisRefereceToUser < ActiveRecord::Migration
  def change
    add_reference :users, :cedi, index: true, foreign_key: true
  end
end
