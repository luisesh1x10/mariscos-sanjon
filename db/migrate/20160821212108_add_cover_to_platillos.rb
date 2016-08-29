class AddCoverToPlatillos < ActiveRecord::Migration
  def up
    add_attachment :platillos, :cover
    
  end

  def down
    remove_attachment :platillos, :cover
  end
end
