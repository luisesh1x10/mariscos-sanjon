class Platillo < ActiveRecord::Base
  belongs_to :category
  has_many :ingredients
  has_many :platillo_ingredient, :through => :ingredients
  accepts_nested_attributes_for :ingredients, allow_destroy: true
  has_attached_file :map, :styles => { :medium => "238x238>", 
                                   :thumb => "100x100>"
                                 }
  validates_attachment :map, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }                               
end
