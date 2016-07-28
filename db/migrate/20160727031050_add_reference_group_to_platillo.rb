class AddReferenceGroupToPlatillo < ActiveRecord::Migration
  def change
    add_reference :platillos, :group, index: true, foreign_key: true
  end
end
