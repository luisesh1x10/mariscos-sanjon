class AddBagIdToSaucerOrder < ActiveRecord::Migration
  def change
    add_reference :saucer_orders, :bag, index: true, foreign_key: true
  end
end
