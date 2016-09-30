class AddCreadorToSaucerOrder < ActiveRecord::Migration
  def change
    add_reference :saucer_orders, :user, index: true, foreign_key: true
  end
end
