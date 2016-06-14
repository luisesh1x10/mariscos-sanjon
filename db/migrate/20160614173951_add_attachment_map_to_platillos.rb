class AddAttachmentMapToPlatillos < ActiveRecord::Migration
  def self.up
    change_table :platillos do |t|
      t.attachment :map
    end
  end

  def self.down
    remove_attachment :platillos, :map
  end
end
